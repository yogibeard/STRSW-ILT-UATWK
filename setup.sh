#!/bin/bash
# Variables

KEY_TYPE="ecdsa"
KEY_FILE="$HOME/.ssh/id_ecdsa"
PASSPHRASE=""
LINUX_MACHINES=("kubmas1-1" "kubwor1-1" "kubwor1-2" "kubwor1-3" "kubmas2-1" "kubwor2-1" "kubwor2-2")
ONTAP_CLUSTERS=("Cluster1" "Cluster2")
VSERVER_NAMES=("Cluster1" "Cluster2")
LINUX_USER="root"
LINUX_PASS="Netapp1!"
ONTAP_USER="admin"
ONTAP_PASS="Netapp1!"
LOCAL_SUDO_PASS="Netapp1!"
COMPLETION_DIR="/etc/bash_completion.d"
COMPLETION_FILE="$COMPLETION_DIR/kubectl.bash"
EXTENSIONS=("ms-kubernetes-tools.vscode-kubernetes-tools" "ms-toolsai.jupyter" "ms-python.python")


# Ensure the completion directory exists
echo $LOCAL_SUDO_PASS | sudo -S mkdir -p $COMPLETION_DIR

# Generate and copy the kubectl completion script
echo $LOCAL_SUDO_PASS | sudo -S bash -c "kubectl completion bash | tee $COMPLETION_FILE > /dev/null"

# Source the completion script in the current shell session
source $COMPLETION_FILE

# Optional: Add to .bashrc for persistence
if ! grep -q "source $COMPLETION_FILE" ~/.bashrc; then
    echo "source $COMPLETION_FILE" >> ~/.bashrc
fi

# Reload .bashrc to apply changes
source ~/.bashrc

echo "kubectl bash completion has been set up and sourced."

# Update and install packages
echo $LOCAL_SUDO_PASS | sudo -S apt update
echo $LOCAL_SUDO_PASS | sudo -S apt install -y sshpass python3-pip python3.8-venv jq

# Generate SSH key if it doesn't exist
if [ ! -f "$KEY_FILE" ]; then
    ssh-keygen -t $KEY_TYPE -f $KEY_FILE -N "$PASSPHRASE"
else
    echo "SSH key already exists at $KEY_FILE"
fi

# Function to copy SSH keys to a remote Linux machine
copy_ssh_keys_linux() {
    local user=$1
    local pass=$2
    local host=$3
    sshpass -p "$pass" ssh -o StrictHostKeyChecking=no "$user@$host" "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
    sshpass -p "$pass" scp -o StrictHostKeyChecking=no "$KEY_FILE" "$KEY_FILE.pub" "$user@$host:~/.ssh/"
    sshpass -p "$pass" ssh -o StrictHostKeyChecking=no "$user@$host" "cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
}

# Function to create a login and add the public key on a NetApp ONTAP cluster
copy_ssh_key_ontap() {
    local user=$1
    local pass=$2
    local host=$3
    local vserver=$4
    local key_file=$5
    local public_key=$(cat $key_file)
    sshpass -p "$pass" ssh -o StrictHostKeyChecking=no "$user@$host" "security login create -vserver $vserver -user-or-group-name $user -application ssh -authentication-method publickey -role admin ; security login publickey create -vserver $vserver -username $user -publickey \"$public_key\""
}

# Function to install specified VSCode extensions
install_vscode_extensions() {
    for extension in "${EXTENSIONS[@]}"; do
        code --install-extension $extension
    done
}

# Copy SSH keys to Linux machines
for machine in "${LINUX_MACHINES[@]}"; do
    copy_ssh_keys_linux $LINUX_USER $LINUX_PASS $machine
done

# Copy SSH key to ONTAP clusters
for i in "${!ONTAP_CLUSTERS[@]}"; do
    copy_ssh_key_ontap $ONTAP_USER $ONTAP_PASS "${ONTAP_CLUSTERS[$i]}" "${VSERVER_NAMES[$i]}" "$KEY_FILE.pub"
done

# Install VSCode extensions
install_vscode_extensions

echo "SSH key has been generated and copied to all specified machines and clusters."
echo "VSCode extensions have been installed."

# Create a virtual environment
python3 -m venv myenv

# Activate the virtual environment
source myenv/bin/activate

# Install Jupyter and bash_kernel within the virtual environment
pip install jupyter
pip install bash_kernel
python -m bash_kernel.install
pip install nbconvert

# Add myenv to .gitignore
if [ ! -f ".gitignore" ]; then
    touch .gitignore
fi

if ! grep -q 'myenv/' .gitignore; then
    echo 'myenv/' >> .gitignore
    echo "Added myenv to .gitignore"
else
    echo "myenv is already in .gitignore"
fi

echo "Installation complete. You can now use bash_kernel in Jupyter notebooks within VSCode."