#### NETAPP LEARNING SERVICES



Exercise Guide

Content Version 3


##### NetApp Learning Services

## Using NetApp Trident with Kubernetes

##### Exercise Guide

Course ID: STRSW-ILT-UATWK
Catalog Number: STRSW-ILT-UATWK-EG


NetApp Learning Services - Do Not Distribute


**ATTENTION**
The information contained in this course is intended only for training. This course contains information and activities that, while
beneficial for the purposes of training in a closed, non-production environment, can result in downtime or other severe
consequences in a production environment. This course material is not a technical reference and should not, under any
circumstances, be used in production environments. To obtain reference materials, refer to the NetApp product documentation
[that is located at http://mysupport.netapp.com/.](http://mysupport.netapp.com/)


**COPYRIGHT**

© 2025 NetApp, Inc. All rights reserved. Printed in the U.S.A. Specifications subject to change without notice.
No part of this document covered by copyright may be reproduced in any form or by any means—graphic, electronic, or
mechanical, including photocopying, recording, taping, or storage in an electronic retrieval system—without prior written
permission of NetApp, Inc.


**U.S. GOVERNMENT RIGHTS**

Commercial Computer Software. Government users are subject to the NetApp, Inc. standard license agreement and applicable
provisions of the FAR and its supplements.


**TRADEMARK INFORMATION**
[NETAPP, the NETAPP logo, and the marks listed at http://www.netapp.com/TM are trademarks of NetApp, Inc. Other company](http://www.netapp.com/TM)
and product names may be trademarks of their respective owners.


Using NetApp Trident with Kubernetes EG-2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Table of Contents**

**Module 0: Welcome ................................................................................................................... M0**


**Module 1: Kubernetes Storage Overview ................................................................................. M1**


**Module 2: Installation ................................................................................................................ M2**


**Module 3: Configuration ............................................................................................................ M3**


**Module 4: Use Scenarios........................................................................................................... M4**


**Module 5: Protection ................................................................................................................. M5**


**Module 6: Business Continuity ................................................................................................. M6**


**Module 7: Monitoring ................................................................................................................. M7**


**Module 8: Security ..................................................................................................................... M8**


**Module 9: Next Steps ................................................................................................................. M9**


**Appendix 1: Kubernetes-Related Certifications ....................................................................... A1**


**Appendix 2: An Introduction To Operators ............................................................................... A2**


**Appendix 3: GitOps Introduction ............................................................................................... A3**


Using NetApp Trident with Kubernetes EG-3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Study Aid Icons**

In your exercises, you might see one or more of the following icons.


**Warning**
If you misconfigure a step marked with this icon, later steps might not
work properly. Check the step carefully before you move forward.


**Attention**
Review this step or comment carefully to save time and avoid errors.


**Information**
Review information about the topic or procedure.


Using NetApp Trident with Kubernetes EG-4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 0: Welcome**

##### **Exercise 1: Setting up the Exercise Equipment**

In this exercise, you familiarize yourself with your equipment and verify that licenses are installed.

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Connect to your NetApp ONTAP cluster

- Verify that required license codes are configured

- Configure Kubernetes administrator access on the jump host

- Set up your IDE

- Optionally, work with YAML files in the IDE

##### **Exercise Equipment**


Your exercise environment contains the following virtual machines:


- One Linux jumphost system

- A 4-node Kubernetes cluster with kubmas1-1 as its control plane node

- An ONTAP 9.13.1 single-node cluster (Cluster1)


Setting up the Exercise Equipment M0-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


When you use the connection information that your instructor assigns to you, you first connect through
a Remote Desktop Connection (RDC) to a Linux jumphost. From this Linux desktop, you can connect to
the other servers in your exercise environment.

|System|Host<br>Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Control Plane 1|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor1-1|192.168.0.62|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor1-2|192.168.0.63|root (case sensitive)|Netapp1!|
|Kubernetes Worker3|kubwor1-3|192.168.0.64|root (case sensitive)|Netapp1!|
|Kubernetes Control Plane 2|kubmas2-1|192.168.0.96|root (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor2-1|192.168.0.97|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor2-2|192.168.0.98|root (case sensitive)|Netapp1!|
|ONTAP cluster management|cluster1|192.168.0.101|admin (case sensitive)|Netapp1!|
|ONTAP cluster node|cluster1-01|192.168.0.111|admin (case sensitive)|Netapp1!|
|ONTAP cluster management|cluster2|192.168.0.102|admin (case sensitive)|Netapp1!|
|ONTAP cluster node|cluster2-01|192.168.0.112|admin (case sensitive)|Netapp1!|



Setting up the Exercise Equipment M0-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 1: Connect to your NetApp ONTAP Cluster**

In this task, familiarize yourself with the jumphost, connect to the ONTAP cluster, and verify its health.

|Step|Action|
|---|---|
|**1-1**|Verify that you see the desktop of your assigned jumphost.<br>|
|**1-2**|To connect to the ONTAP cluster UI, browse to the NetApp ONTAP System<br>Manager URL, which is built into the ONTAP software. To connect to the ONTAP<br>cluster CLI, use Secure Shell (SSH).|
|**1-3**|Double-click the terminal shortcut.<br> <br>|
|**1-4**|In the terminal window, enter the following text:~~**`ssh admin@192.168.0.101`**~~|
|**1-5**|You can also connect to the ONTAP cluster CLI by connecting to a node in the<br>cluster: Cluster-01 (node 1).|
|**1-6**|At the ONTAP password prompt, provide the following credentials:**Netapp1!** <br>The ONTAP cluster CLI prompt and cursor appear.|
|**1-7**|Enter the following command to verify that the single node of the ONTAP cluster is healthy and<br>eligible:**`cluster show `**|


##### **Task 2: Verify that required license codes are configured**


Many advanced features of the ONTAP cluster require licenses. In later exercises, you use several
licensed features of the ONTAP cluster. In this task, verify that the necessary licenses are preinstalled.

|Step|Action|
|---|---|
|**2-1**|In the cluster1 CLI, enter the following command:~~**`license show`**~~|
|**2-2**|Verify that the following required license codes are installed:<br>• <br>NFS<br>• <br>iSCSI<br>• <br>NVMe<br>• <br>FlexClone<br>• <br>S3|
|**2-3**|If any of the licenses are not installed, inform your instructor.|
|**2-4**|You can close this terminal window if desired.|



Setting up the Exercise Equipment M0-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 3: Configure Kubernetes Administrator access on the jump host**

In this task, you set up Kubernetes administrator access on the jump host.

|Step|Action|
|---|---|
|**3-1**|On your jump host, open a new terminal window.|
|**3-2**|Install**kubectl** by using the Linux Snap tool.<br>**`snap install kubectl --channel=1.29/stable --classic`**|
|**3-3**|When requested to authenticate the installation of the package, enter**Netapp1!**|
|**3-4**|Click**Authenticate**to complete the installation.|
|**3-5**|Verify the installation and the version.<br>**`kubectl version --client -o json`**|
|**3-6**|Verify the Kubernetes configuration.<br>**`kubectl config view`**|
|**3-7**|The results are empty. You have not yet authenticated with the Kubernetes cluster on<br>your jump host and you have no authorization to run any commands. You correct this<br>situation now.<br>|
|**3-8**|Run~~**`pwd`**~~ to confirm that your working directory for the user account is`/home/user`.|
|**3-9**|Create a hidden folder called .kube under your working directory.<br>**`mkdir .kube`**|
|**3-10**|You add the kubeconfig file after you set up the IDE.|


##### **Task 4: Add the courseware to the IDE**


Throughout this course, you edit and run YAML files. If you plan to take the Kubernetes certification
exams, you should be comfortable with creating and editing YAML files by using Nano on a Linux host.
However, this procedure is not practical for daily operations. In this task, you configure Visual Studio
Code (VSC) as your IDE to use in this class. VSC is one of the world’s most popular IDEs. This course
uses IDE and VSC interchangeably.

|Step|Action|
|---|---|
|**4-1**|Install the Kubernetes extension for VSC.<br>**`code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools`**|
|**4-2**|From the terminal, launch Visual Studio Code.<br>**`code`**|
|**4-3**|Verify that the IDE opens.|



Setting up the Exercise Equipment M0-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-4**|Periodically, VSC might release updates. If an update is available, you can select the<br>gear icon with the badge indicator at the bottom left of the IDE and then select<br>**Restart to Update**.|
|**4-5**|Select a**Theme** and click**Mark Done**.|
|**4-6**|Click**Clone Git Repository** in the main pane.<br>|
|**4-7**|Enter the following in the text box: <br>**`https://github.com/NetApp-Learning-Services/STRSW-ILT-UATWK`**|
|**4-8**|Select a location to store your local clone of the courseware repository.|
|**4-9**|For example, you can create a “repos” folder under`/home/user` by clicking the<br>Create Folder icon<br> and then selecting that folder.|
|**4-10**|After you clone the repository, open that repository in the same window by clicking**Open**.|
|**4-11**|Click**Yes, I trust the authors**.|
|**4-12**|Open a new terminal within your IDE by selecting**Terminal > New Terminal** from the menu.|
|**4-13**|In the bash terminal, change directory to Exercise 0.<br>**`cd ‘Exercise 0’`**|
|**4-14**|Run a bash script.<br>**`./exercise0Task4.sh`**|
|**4-15**|When prompted, enter the password for root.<br>**`Netapp1!`**|
|**4-16**|You should now have a kubeconfig file that references your Kubernetes cluster. You<br>can investigate this file at /home/user/.kube.|
|**4-17**|In the left column, select the**Kubernetes** <br> icon.|
|**4-18**|If prompted, install the required dependencies.|
|**4-19**|You might have to repeat this action until you have installed all the dependencies.|


Setting up the Exercise Equipment M0-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-20**|The Kubernetes extension should now be authenticated with your Kubernetes<br>cluster.<br>The Kubernetes extension enables you to explore your Kubernetes cluster visually.<br>|
|**4-21**|Expand the**Nodes** list of the active cluster and verify that you see kubmas1-1, kubwor1-1,<br>kubwor1-2, and kubwor1-3.<br> <br>|
|**4-22**|Explore the information that this extension displays.|
|**4-23**|Navigate back to**Explorer** by clicking the Explorer<br> icon.|
|**4-24**|You should now have an Explorer view of the files and folders from the repository for<br>this class.|

##### **Task 5: Work with YAML files in the IDE (Optional)**

In this task, you use your IDE to deploy a pod within your Kubernetes cluster. You can skip this task.

|Step|Action|
|---|---|
|**5-1 **|In your IDE Explorer window, navigate to the**Exercise 0** folder (which represents the exercise<br>for Module 0) and select the file**exercise0task5.yaml**. <br>|



Setting up the Exercise Equipment M0-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-2 **|Under the`name` key, type~~**`namespace: default`**~~ to ensure that this pod runs in the default<br>namespace.|
|**5-3 **|Spacing matters. You must ensure that this key-value pair is a sibling of the`name` <br>key value.<br> <br> <br>If you have difficulty, you can find a completed version of the YAML file in this exercise’s<br>“Solutions” subfolder.|
|**5-4 **|Notice the color dot on the tab next to the file name.|
|**5-5 **|The dot indicates that the file has changed and needs to be saved, so press**Ctrl-S** to save the<br>file.|
|**5-6 **|With this file open, press**Ctrl-Shift-P**(**Cmd-Shift P**on a Mac), or select** View menu >**<br>**Command Palette**, and then start typing**`Kubernetes`** to see a list of Kubernetes-related<br>commands.<br>|
|**5-7 **|Select~~**`Kubernetes: Create`**~~ to execute the YAML definition file.|
|**5-8 **|You should see a dialog box that tells you that the pod or front end was created. It will take a<br>few minutes to schedule and pull the image for the pod’s creation.|
|**5-9 **|Navigate to the Kubernetes extension in your IDE and try to find the pod that you created.|
|**5-10**|Navigate to**Workloads > Pods** and select the front-end pod.<br>|


Setting up the Exercise Equipment M0-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-11**|Double-click the front-end pod to review the pod’s running configuration.<br>|
|**5-12**|Alternatively, you can get details about your pod by running the following command:<br>**`kubectl describe pod frontend`**|
|**5-13**|As you review the command output, examine the Events section at the bottom of the<br>window for any errors in the pod.|
|**5-14**|Right-click the front-end pod in the extension, select**Delete Now** to remove the pod, and<br>confirm the deletion in the dialog box.|
|**5-15**|Close the**exercise0task5.yaml** file in the IDE.|
|**5-16**|This course includes CHALLENGE STEPS to help you to explore deeper sections of<br>the ecosystem.<br>These CHALLENGE STEPS are optional, but you cannot skip steps if you want to<br>complete the entire challenge.|
|**5-17**|CHALLENGE STEP: In November 2020, Docker Hub instituted a new policy that limits the<br>number of pulls that are available from an anonymous account, like the one that we use.|
|**5-18**|If you reach the limit, you see the following error in Events:<br>`docker: Error response from daemon: toomanyrequests: You have reached`<br>`your pull rate limit. You may increase the limit by authenticating`<br>`and upgrading:https://www.docker.com/increase-rate-limit`|


Setting up the Exercise Equipment M0-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-19**|CHALLENGE STEP: To verify your anonymous usage, perform the following steps:<br>1. Install jQuery (if it is not already installed).<br>**`sudo apt install -y jq`** <br>2. Create a token variable.<br>**`TOKEN=$(curl`**<br>**`"https://auth.docker.io/token?service=registry.docker.io`**<br>**`&scope=repository:ratelimitpreview/test:pull" | jq -r .token)`** <br>3. Use the token variable and review the HTML header output.<br>**`curl --head -H "Authorization: Bearer $TOKEN" https://registry-`**<br>**`1.docker.io/v2/ratelimitpreview/test/manifests/latest`** <br>Example output:<br>`ratelimit-limit: 100;w=21600`<br>`ratelimit-remaining: 76;w=21600 `<br>No space<br>between lines|
|**5-20**|These commands are available in the class’s GitHub repository in the Extras/pull-limit<br>folder.|
|**5-21**|CHALLENGE STEP: To resolve this restriction, perform the following steps:<br>1. Navigate to Docker Hub (https://hub.docker.com) and register for a free account.<br>2.Use the authentication account when you request pulls from Kubernetes. (You must<br>create the secret in every namespace in which you use the account). <br>a.Create a secret with your authentication credentials. <br>**`kubectl create secret docker-registry dockerhubkey \`**<br>**`       --docker-username=[`****_`USERNAME`_****`] \`**<br>**`       --docker-password=[`****_`PASSWORD`_****`] \`**<br>**`       --docker-email=[`****_`EMAIL OF THE FREE ACCOUNT`_****`]`** <br>`b.` Edit the default service account and add the`imagePullSecrets` option.<br>**`kubectl -n default edit serviceaccount default `** <br>`apiVersion: v1`<br>`kind: ServiceAccount`<br>`metadata:`<br>` creationTimestamp: 2015-08-07T22:02:39Z`<br>` name: default`<br>` namespace: default`<br>` uid: 052fb0f4-3d50-11e5-b066-42010af0d7b6`<br>`secrets:`<br>`- name: default-token-uudge`<br>**`imagePullSecrets:`**<br>**`      - name: dockerhubkey`**|


Setting up the Exercise Equipment M0-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-22**|CHALLENGE STEP: To verify the usage of a Docker account, perform the following steps:<br>1. Install jQuery (if it is not already installed)<br>**`sudo apt install -y jq`** <br>2. Create a token variable, replacing the`username` and`password` <br>with your account details.<br>**`MYTOKEN=$(curl --user '`****_`username:password`_****`' `**<br>**`"https://auth.docker.io/token?service=registry.docker.io`**<br>**`&scope=repository:ratelimitpreview/test:pull" | jq -r .token)`** <br>**3.**Use the token variable and review the HTML header outpu.:<br>**`curl --head -H "Authorization: Bearer $MYTOKEN"`**<br>**`https://registry-`**<br>**`1.docker.io/v2/ratelimitpreview/test/manifests/latest` **<br>Example output: <br>`ratelimit-limit: 200`<br>`ratelimit-remaining: 176` <br>No space<br>between lines|


**End of exercise**


Setting up the Exercise Equipment M0-E1-P10


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 1: Kubernetes Storage Overview**

##### **Exercise 1: Working with Kubernetes Storage Volumes**

In this exercise, you explore native Kubernetes storage objects, including emptyDir, hostPath, and NFS
volume types. You also create a manual persistent volume (PV) and persistent volume claim (PVC).

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Set up an emptyDir volume

- Configure a hostPath volume

- Deploy a pod with two containers that share storage

- Configure an NFS server by using NetApp ONTAP software

- Set up an NFS volume

- Configure a PV and a PVC

##### **Exercise Equipment**


In this exercise, you use the following systems:

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor1-1|192.168.0.62|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor1-2|192.168.0.63|root (case sensitive)|Netapp1!|
|Kubernetes Worker 3|kubwor1-3|192.168.0.64|root (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your Integrated Development Environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to have access to your Kubernetes clusters

##### **Task 1: Set up an emptyDir volume**


In this task, you create the simplest volume option available in Kubernetes: emptyDir.

|Step|Action|
|---|---|
|**1-1**|All files in this exercise have the relative path of`Exercise 1`. If you use kubectl<br>command via a terminal window, change directory to the`Exercise 1` directory.|



Working with Kubernetes Storage Volumes M1-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-2**|Review and update the`exercise1Task1.yaml` file with the following information, and then<br>save the file.<br>• <br>volumeMounts:<br>`o` mountPath:**/opt/this** <br>`o` name:**myvol** <br>• <br>volumes:<br>`o` name:**myvol** <br>`o` emptyDir:**{}**|
|**1-3**|Create an instance of the`exercise1Task1.yaml` file:<br>**`kubectl create -f exercise1Task1.yaml` **|
|**1-4**|Describe the pod again and review the events:<br>**`kubectl describe pod emptydir-pod` **|
|**1-5**|Answer the following question:<br>Is the pod running?|
|**1-6**|Connect to the pod:<br>**`kubectl exec -it emptydir-pod -- /bin/sh` **|
|**1-7**|From the container’s prompt, list the directory of the`/opt/this` directory.|
|**1-8**|From the container’s prompt, create a file with the`touch` command in the`/opt/this` <br>directory.|
|**1-9**|From the container’s prompt, list the directory of the`/opt/this` directory.|
|**1-10**|Exit the container’s prompt.|
|**1-11**|Delete the`emptyDir` pod:<br>**`kubectl delete pod emptydir-pod `**|
|**1-12**|This course includes CHALLENGE STEPS to help you to explore deeper sections of<br>the Kubernetes ecosystem. NOTE: These CHALLENGE STEPS are optional, but you<br>cannot skip steps if you want to complete the entire challenge.|
|**1-13**|CHALLENGE STEP: Run steps 1-2 through 1-6 again, and answer the following question:<br>Does the file that you created in step 1-7 still exist?|
|**1-14**|CHALLENGE STEP: Exit the container’s prompt and delete the second instance of the<br>emptyDir pod.|


Working with Kubernetes Storage Volumes M1-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 2: Configure a hostPath volume**

In this task, you create a Debian container and provide access to a local mount point on the hosting
worker node.

|Step|Action|
|---|---|
|**2-1**|Review and update the`exercise1Task2-1.yaml` file with the following definitions, and then<br>save the file.<br>• <br>spec volumes:<br>`o` name:**local-vol** <br>`o` hostPath:<br> <br>path:**/hostVol** <br> <br>type:**Directory** <br>• <br>Containers volumeMounts:<br>`o` mountPath:**/root/** <br>`o` name:**local-vol**|
|**2-2**|<br>You can find the solution in the subfolder.|
|**2-3**|Create an instance of the`exercise1Task2-1.yaml` file:<br>**`kubectl create -f exercise1Task2-1.yaml` **<br>|
|**2-4**|Identify which node the pod is running on by using the~~**`kubectl get pods -o wide`**~~ <br>command.|
|**2-5**|Describe the pod, review the events, and answer the following questions:<br>Is the pod running? Why or why not?|
|**2-6**|Using a new terminal window, open a Secure Shell (SSH) session to the worker node that is<br>assigned to the pod:<br>`ssh root@192.168.0.6x `|
|**2-7**|When prompted, enter the following password:**Netapp1!**<br>The Linux CLI prompt and cursor appear.|
|**2-8**|From the worker node’s prompt, create the required directory:<br>**`mkdir /hostVol` **|
|**2-9**|From the worker node’s prompt, create a local file in the directory:<br>**`touch /hostVol/exercise1Task2` **|
|**2-10**|<br>Wait a few minutes for the pod to identify the new directory.|
|**2-11**|Switch back to your jumphost, describe the pod again, and review the events:<br>**`kubectl describe pod hostpath-pod` **|



Working with Kubernetes Storage Volumes M1-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-12**|Answer the following question:<br>Is the pod running?|
|**2-13**|<br>The pod should be running. If the pod is not running, delete the pod and re-create it.|
|**2-14**|Connect to the pod:<br>**`kubectl exec -it hostpath-pod -- /bin/sh` **|
|**2-15**|From the container’s prompt, list the directory of the`/root` directory.|
|**2-16**|Answer the following question:<br>Do you see the file that you created from the local worker node?|
|**2-17**|From the container’s prompt, create a file in the`/root` directory.|
|**2-18**|Answer the following question:<br>Do you see the file that you created from the SSH session on the local worker node?|
|**2-19**|Answer the following question:<br>What happens to file access if the pod is destroyed and re-created on the other worker node?|
|**2-20**|Delete the pod:<br>**`kubectl delete pod hostpath-pod` **|
|**2-21**|Copy the completed YAML file and rename the copy as**exercise1Task2-2.yaml**.|
|**2-22**|Change the following in the`exercise1Task2-2.yaml` file and then save the file.<br>• <br>Pod name:**hostpath2-pod** <br>• <br>hostPath:<br>`o` path:**/hostVol2** <br>`o` type:**DirectoryOrCreate**|
|**2-23**|Create an instance of the`exercise1Task2-2.yaml` file:<br>**`kubectl create -f exercise1Task2-2.yaml` **|
|**2-24**|Describe the pod again, and review the events:<br>**`kubectl describe pod hostpath2-pod` **|
|**2-25**|Answer the following question:<br>Is the pod running?|
|**2-26**|Notice that the`/hostVol2` was created on the appropriate worker node.|
|**2-27**|Connect to the pod:<br>**`kubectl exec -it hostpath2-pod -- /bin/sh` **|
|**2-28**|From the container’s prompt, list the directory of the`/root`directory.|


Working with Kubernetes Storage Volumes M1-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-29**|From the container’s prompt, create a file in the mounted path.|
|**2-30**|Use**Ctrl-D** to exit to the execute command.|
|**2-31**|Delete the`hostpath2-pod` pod.|
|**2-32**|CHALLENGE STEP: Delete and re-create the pod, see which node is selected to host the<br>second instance of the pod, and answer the following question:<br>What happens to the hostPath directory on the local worker node?|

##### **Task 3: Deploy a pod with two containers that share storage**

In this task, you define a volume named `shared-data` . The volume’s type is `emptyDir` . The first
container runs an NGINX server and mounts the shared volume to the directory
`/usr/share/nginx/html` . The second container is based on the Debian image. The second
container mounts the shared volume to the directory `/pod-data`, which runs a loop that writes the
current date and time to the `index.html` file in the shared volume. The container waits 10 seconds

before repeating the loop. This task uses nodeport service. For more information regarding this service
type, please see Kubernetes Administration.

|Step|Action|
|---|---|
|**3-1**|Review and update the`exercise1Task3.yaml` file with the following definitions, and then<br>save the file.<br>• <br>.spec.volumes<br>`o` Name:**shared-vol** <br>`o` Add an emptyDir volume definition.<br>• <br>In both containers’ volumeMounts definition, use the name**shared-vol.**|
|**3-2**|<br>You can find the solution in the subfolder.|
|**3-3**|Create an instance of the`exercise1Task3.yaml` file:<br>**`kubectl create -f exercise1Task3.yaml` **|
|**3-4**|Connect to the`first` container of the pod:<br>**`kubectl exec -it two-pod -c first -- /bin/sh`**|
|**3-5**|From the container’s prompt, verify that the`index.html` page is being updated every second:<br>**`# tail /usr/share/nginx/html/index.html` **|
|**3-6**|Use**Ctrl-D** to exit to the execute command.|
|**3-7**|Create a service that enables a worker node to access the`two-pod`: <br>**`kubectl expose pod two-pod --type=NodePort --port=80` **|
|**3-8**|Identify the service node port:<br>**`kubectl describe service two-pod `**|



Working with Kubernetes Storage Volumes M1-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-9**|Open a web browser to the following URL:~~**`http://[`**~~**_`a worker node’s IP`_**<br>**_`address`_****`]:[`****_`node port from previous step`_****`]`**. <br>Sample output:<br>`Fri Feb 25 17:05:43 UTC 2024 Hello from the second container`<br>`Fri Feb 25 17:05:44 UTC 2024 Hello from the second container`<br>`Fri Feb 25 17:05:45 UTC 2024 Hello from the second container`<br>`Fri Feb 25 17:05:46 UTC 2024 Hello from the second container`|
|**3-10**|Delete the pod named`two-pod` and remove the service. HINT: To remove a service, use<br>`kubectl delete service [name of service]`.|

##### **Task 4: Configure an NFS server by using NetApp ONTAP software**

In this task, you configure a storage VM (storage virtual machine, also known as SVM) for NFS
protocols. You use an open-source tool called gateway (Method 1) to create this SVM. You can also
skip steps 4-2 through 4-11 and use steps 4-13 through 4-32 (Method 2) to create this SVM manually.

|Step|Action|
|---|---|
|**4-1**|To create your SVM, use_either_ Method 1 (steps 4-2 through 4-11)_or_ Method 2<br>(steps 4-13 through 4-24).|
|**4-2**|Method 1: Review and execute the`exercise1Task4-1.yaml` file to create the gateway<br>operator. For more information, on the non-NetApp supported community project, see this:<br>https://github.com/NetApp-Learning-Services/gateway.|
|**4-3**|Method 1: Verify that you created the `gateway-system` namespaceand that the operator pod<br>is running in that namespace.|
|**4-4**|Method 1: Review and execute the`exercise1Task4-2.yaml` file to create an SVM called <br>`svm0` with the defined protocol in ONTAP Cluster 1.|
|**4-5**|Method 1 CHALLENGE STEP: Review the logs of the`manager` container for the`gateway-`<br>`manager` deployment’s pod to see the gateway operator in action:<br>**`kubectl -n gateway-system logs gateway-operator-[`****_`unique id`_****`] -c manager` **|
|**4-6**|Method 1: Open a browser and go to**https://192.168.0.101/** <br>(which is your Cluster1 management LIF’s address).<br> <br>NOTE: You might need to approve the security warning.|
|**4-7**|Method 1: For now, use the standard System Manager. Click the link:**Not now. Sign in to**<br>**System Manager.**Skip this step if you already have selected System Manager instead of<br>using NetApp BlueXP.|
|**4-8**|Method 1: Authenticate with your ONTAP cluster by providing the following credentials:<br>• <br>Login as:**admin** <br>• <br>Password:** Netapp1!**|
|**4-9**|Method 1: Click**Sign In**.|



Working with Kubernetes Storage Volumes M1-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-10**|Method 1: From the left pane, navigate to**Storage > Storage VMs**.|
|**4-11**|Method 1: Review the settings of`svm0` and verify that NFS is configured. Also verify that the <br>`Cluster1_01_FC_1` is an available local tier for this SVM by clicking Edit on the SVM.|
|**4-12**|Remember: Skip the following steps if you already executed Method 1 (steps 4-2<br>through 4-11).|
|**4-13**|Method 2: Open a browser and go to**https://192.168.0.101/** <br>(which is your Cluster1 management LIF’s address).<br> <br>NOTE: Approve the security warning if needed.|
|**4-14**|Method 2: Authenticate with your ONTAP cluster by providing the following credentials:<br>• <br>Login as:**admin** <br>• <br>Password:** Netapp1!**|
|**4-15**|Method 2: Click**Sign In**.|
|**4-16**|Method 2: From the left pane, navigate to**Storage > Storage VMs**.|
|**4-17**|Method 2: Click**Add** to start the wizard to create an SVM.|
|**4-18**|Method 2: Enter the following information:<br>• <br>Storage VM name:**svm0** <br>• <br>Select the tab**SMB/CIFS, NFS, S3**. <br>• <br>Access protocol: Select**Enable NFS**. <br>• <br>Enable NFS client access: Selected<br>• <br>Rule: Add a rule:<br>`o` Client specification:**0.0.0.0/0** <br>`o` Protocols:**NFS** (both**v3** and**v4**) <br>`o` Read-only:**All**selected<br>`o` Read/write:**All** selected<br>`o` Superuser:**All** selected<br>`o` Click**Save**. <br>• <br>Under Network Interface:<br>`o` IP address:**192.168.0.31** <br>`o` Subnet mask:**255.255.255.0** <br>`o` Broadcast domain: Default|


Working with Kubernetes Storage Volumes M1-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-19**|Method 2: Continue by entering the following information:<br>Manage administrator account: Selected<br>`o` User name:**vsadmin** <br>`o` Password:**Netapp1!** <br>`o` Verify password:**Netapp1!** <br>`o` Select**Add a network interface for storage VM management** <br> <br>IP address:**192.168.0.30** <br> <br>Subnet mask:**24**<br> <br>Broadcast domain:**Default**|
|**4-20**|Method 2: At the bottom of the dialog box, click**Save**. <br>You should see`svm0` in the list of SVMs.|
|**4-21**|Method 2: Click the newly created**svm0** link.<br>You should see the Overview page of`svm0`.|
|**4-22**|Method 2: Click the**Edit** button in the upper-right corner of the Overview page.|
|**4-23**|Method 2: Select the “Resource Allocation” checkbox to limit volume creation to preferred local<br>tiers, and make sure that`Cluster1_01_FC_1` is selected in the list of local tiers.|
|**4-24**|Method 2: Click**Save**.|
|**4-25**|This is the end of the SVM creation steps. You should now have a svm0 in<br>cluster1. You will now continue along with the setting up the NFS share.|
|**4-26**|In ONTAP System Manager, navigate to**Storage > Volumes**.|
|**4-27**|Click**Add** to create a volume.|
|**4-28**|Add the following details:<br>• <br>Name:**nfs** <br>• <br>Size:**1GiB** <br>• <br>Click the**More** button.<br>• <br>Ensure that the “Export via NFS” checkbox is selected.<br>• <br>Ensure that the default rule has all NFS protocols selected with the clients of 0.0.0.0/0.|
|**4-29**|Click**Save**to create the volume.|
|**4-30**|From the list of volumes, identify and select the link for the new`nfs` volume.|
|**4-31**|On the`nfs` volume's Overview page, click the**Edit** button in the upper-right corner.|
|**4-32**|In the details of the volume, perform the following:<br>• <br>Ensure that the security type is UNIX.<br>• <br>Under UNIX Permissions, select**Read**, **Write**, and**Execute** so that all checkboxes are<br>selected.|


Working with Kubernetes Storage Volumes M1-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-33**|Click**Save**to complete the volume’s edit.|

##### **Task 5: Set up an NFS volume**

In this task, you create a pod that directly connects to the NFS export that you created in Task 4 of this
exercise. NOTE: Every node in the Kubernetes cluster needs to have the `nfs-common` package
installed to appropriately mount an NFS export for a container.

|Step|Action|
|---|---|
|**5-1**|Review and update the`exercise1Task5.yaml` file with the following definitions, and then<br>save the file.<br>spec volumes:<br>`o` name:**nfsvol** <br>`o` nfs:<br> <br>server:**192.168.0.31** <br> <br>path:**/nfs** <br> <br>readOnly:**false**|
|**5-2**|<br>You can find the solution in the subfolder.|
|**5-3**|Create an instance of the`exercise1Task5.yaml` file:<br>**`kubectl create -f exercise1Task5.yaml` **|
|**5-4**|Connect to the alpine pod that you created:<br>**`kubectl exec direct-nfs-pod -it -- /bin/sh` **|
|**5-5**|From the container’s prompt, change the directory to volume mount:<br>**`# cd /opt/this` **|
|**5-6**|From the container’s prompt, create a file and perform other operations at this location to<br>demonstrate that you have read/write permission:<br>**`# echo "<html><body>hello</body></html>" > index.html`**<br>**`# ls`**<br>**`# cat index.html`**|
|**5-7**|Use**Ctrl-D** to exit the container’s prompt.|
|**5-8**|Delete the pod:<br>**`kubectl delete pod direct-nfs-pod` **|
|**5-9**|In the ONTAP System Manager, under the`nfs` volume page, you can select the<br>Explorer tab under the File System tab to view the folders and files that you created<br>in the pod. The data is persisted in the ONTAP cluster.|



Working with Kubernetes Storage Volumes M1-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 6: Configure a PV and a PVC**

In this task, you create a PV that is manually attached to the NFS export that you created in Task 4.
Then, you bind that PV to a PVC. Finally, you use the PVC in a pod so that the pod’s container can
access the NFS export. Later, you use NetApp Astra Trident to automate this process of creating PVs.

|Step|Action|
|---|---|
|**6-1**|Review and update the`exercise1Task6-1.yaml` file with the following PV specification<br>definitions**, **and then save the file.<br>Add an`nfs` definition with the following values:<br>`o` server:**192.168.0.31** <br>`o` path:**/nfs**<br>`o` <br>readOnly:**false** <br>You can find the solution in the subfolder.|
|**6-2**|Create an instance of the PV in the`exercise1Task6-1.yaml` file:<br>**`kubectl create -f exercise1Task6-1.yaml` **|
|**6-3**|Verify that you created the`manual-nfs-pv` PV:<br>**`kubectl get pv` **|
|**6-4**|Describe the`manual-nfs-pv` PV:<br>**`kubectl describe pv manual-nfs-pv` **|
|**6-5**|Review and update the`exercise1Task6-2.yaml` file with the following PVC spec<br>definitions, and then save the file.<br>• <br>accessModes:**ReadWriteMany** <br>• <br>storageClassName:** '' # empty string** <br>• <br>volumeName: **_[name of the PV from step 6-3]_** <br>• <br>resources:requests:storage:**1Gi** <br>You can find the solution in the subfolder.|
|**6-6**|Create an instance of the PVC in the`exercise1Task6-2.yaml` file:<br>**`kubectl create -f exercise1Task6-2.yaml` **|
|**6-7**|Verify that you created the`manual-nfs-pvc` PVC:<br>**`kubectl get pvc` **|
|**6-8**|Describe the`manual-nfs-pvc` PVC:<br>**`kubectl describe pvc manual-nfs-pvc` **|
|**6-9**|Ensure that the PVC’s status is`bound`, which means that the PVC was mapped to the PV.|



Working with Kubernetes Storage Volumes M1-E1-P10


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-10**|Review and update the`exercise1Task6-3.yaml` file with the following Pod volumes<br>definitions, and then save the file.<br>• <br>name:**nfs-storage**<br>• <br>persistentVolumeClaim:claimName: [**_name of the PVC you created in step 6-8_**]|
|**6-11**|Create an instance of the PVC in the`exercise1Task6-3.yaml` file:<br>**`kubectl create -f exercise1Task6-3.yaml` **|
|**6-12**|Verify that you created the`manual-nfs-pod` pod:<br>**`kubectl get pod` **|
|**6-13**|Describe the`manual-nfs-pod` pod:<br>**`kubectl describe pod manual-nfs-pod`**|
|**6-14**|Ensure that the pod is using the PV that is backed by the NFS export in`svm0`.|
|**6-15**|CHALLENGE STEP: Open an SSH session, go to the`manual-nfs-pod`, and navigate to the<br>mount path of the PV. Verify that the`index.html` file that you created in the previous task is<br>available to the NGINX server.|
|**6-16**|CHALLENGE STEP: Create a NodePort service for the`manual-nfs-pod` and, in a browser,<br>open the`index.html` file that you created.|
|**6-17**|Delete the`manual-nfs-pod` pod:<br>**`kubectl delete pod manual-nfs-pod` **|


**End of exercise**


Working with Kubernetes Storage Volumes M1-E1-P11


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 2: Trident Installation**

##### **Exercise 1: Installing Trident**

In this exercise, you install NetApp Trident by using the manual operator method. You can also use
Helm or the `tridentctl` method to install the Trident operator, but this exercise does not discuss
these other approaches.

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Download and set up the Trident operator

- Deploy instances of Trident

- Set up the `tridentctl` tool

- Prepare worker nodes

##### **Exercise Equipment**


In this exercise, you use the following systems.

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Control Plane|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor1-1|192.168.0.62|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor1-2|192.168.0.63|root (case sensitive)|Netapp1!|
|Kubernetes Worker 3|kubwor1-3|192.168.0.64|root (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your Integrated Development Environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to have access to your Kubernetes clusters

- Create svm0

- Configure svm0 to use the NFS v3 protocol

##### **Task 1: Download and set Up the Trident operator**


In this task, you verify that you can access the Kubernetes cluster, and you download and set up the
Trident operator.

|Step|Action|
|---|---|
|**1-1**|If desired, you can follow along with this exercise on the Trident operator deployment:<br>https://docs.netapp.com/us-en/trident/trident-get-started/kubernetes-deploy-<br>operator.html#deploy-the-trident-operator-manually.|



Installing Trident M2-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-2**|Verify that you have administrative access to the Kubernetes cluster:<br>**`kubectl auth can-i '*' '*' --all-namespaces` **|
|**1-3**|In a future exercise, you implement Container Storage Interface (CSI) topologies. To<br>support this effort, you apply different labels to each worker node. These labels<br>should be present on the nodes in the cluster before you install Trident. The labels<br>enable Trident to be topology-aware.|
|**1-4**|Label Worker 1 as Zone 1 and a region (for convenience, see`exercise2Task1-1.txt`):<br>**`kubectl label node kubwor1-1 topology.kubernetes.io/region=trident`**<br>**`topology.kubernetes.io/zone=zone1` **|
|**1-5**|Label Worker 2 as Zone 2 and a region (for convenience, see`exercise2Task1-2.txt`):<br>**`kubectl label node kubwor1-2 topology.kubernetes.io/region=trident`**<br>**`topology.kubernetes.io/zone=zone2` **|
|**1-6**|Label Worker 3 as Zone 3 and a region (for convenience, see`exercise2Task1-3.txt`):<br>**`kubectl label node kubwor1-3 topology.kubernetes.io/region=trident`**<br>**`topology.kubernetes.io/zone=zone3`**|
|**1-7**|Use a web browser to navigate tohttps://github.com/Netapp/trident/releases.|


Installing Trident M2-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-8**|Identify the latest version of Trident at the top of the page:|


Installing Trident M2-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-9**|If desired, you can download a newer version. However, this exercise is not tested<br>with any version other than 24.10.0. If you want to work with this version of the<br>exercise, you can find the tar.gz file in the Exercise 2 folder in your class files.|
|**1-10**|Open a terminal in your integrated development environment (IDE).|
|**1-11**|In the terminal, change the directory to the Exercise 2 subfolder:<br>**`cd 'Exercise 2' `**|
|**1-12**|Unzip the Trident file:<br>**`tar -xf trident-installer-24.10.0.tar.gz`**<br>A new subfolder, called`trident-installer`, should appear under the Exercise 2 folder.|
|**1-13**|In the terminal, navigate to the**Exercise 2 > trident-installer**folder.<br> <br>NOTE: This path serves as the relative path for all other paths in this task and the next task.|
|**1-14**|Investigate the**deploy/crds** subfolder.|
|**1-15**|The**crds** subfolder contains several custom resource definition (CRD) YAML files.<br>Notice that three custom resource definitions (CRD) files with`crd` in the filenames<br>and six of these custom resources files with`cr` in the filenames.|
|**1-16**|Create the CRD definitions by using the<br>trident.netapp.io_tridentorchestrators_crd_post1.16.yaml file:<br>**`kubectl create -f`**<br>**`deploy/crds/trident.netapp.io_tridentorchestrators_crd_post1.16.yaml`**|
|**1-17**|In the Kubernetes Extension of your IDE, you should see the<br>`tridentorchestrators` CRD.<br> <br> <br>If you see an error under the`tridentorchestrators` CRD, click the**Refresh** button to<br>make it disappear.|
|**1-18**|Create the`trident` namespace:<br>**`kubectl create -f deploy/namespace.yaml `**|
|**1-19**|Copy and rename the resulting file for the aggregated YAML “kustomized” file for Kubernetes<br>version 1.25 or later (for convenience, see` exercise2Task1-4.txt`):<br>**`cp deploy/kustomization_post_1_25.yaml deploy/kustomization.yaml` **|


Installing Trident M2-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-20**|NOTE: This kustomization.yaml file runs the serviceaccount.yaml, clusterrolebinding.yaml, and<br>the operator.yaml files.|
|**1-21**|Create a YAML bundle that you can run (for convenience, see` exercise2Task1-5.txt`):<br>**`kubectl kustomize deploy/ > deploy/bundle_post_1_25.yaml` **|
|**1-22**|Install the operator (for convenience, see` exercise2Task1-6.txt`):<br>**`kubectl create -f deploy/bundle_post_1_25.yaml` **|
|**1-23**|Verify that you created all the objects:<br>**`kubectl -n trident get all`**<br>Sample output:<br>`NAME                  READY  STATUS  RESTARTS  AGE`<br>`pod/trident-operator-5c94fc5556-nlsnl  1/1   Running  0     2m7s`<br> <br>`NAME                READY  UP-TO-DATE  AVAILABLE  AGE`<br>`deployment.apps/trident-operator  1/1   1      1      2m7s`<br> <br>`NAME                     DESIRED  CURRENT  READY  AGE`<br>`replicaset.apps/trident-operator-5c94fc5556  1     1     1    2m7s `|
|**1-24**|A Kubernetes cluster should contain only_one instance_ of the operator. You must not<br>create multiple deployments of the Trident operator.|

##### **Task 2: Deploy instances of Trident**

In this task, you use the operator to deploy Trident. This action requires you to create a
`TridentOrchestrator` custom resource (CR). The Trident installer includes example definitions for
creating the `TridentOrchestrator` CR. This CR starts an installation in the `trident` namespace.
The relative path for this exercise is the **Exercise 2 > trident-installer** folder.

|Step|Action|
|---|---|
|**2-1**|Review the deploy/crds/tridentorchestrator_cr.yaml file.|
|**2-2**|Create an instance of the`TridentOrchestrator` CR:<br>**`kubectl create -f deploy/crds/tridentorchestrator_cr.yaml `**|
|**2-3**|In the Kubernetes Extension of your IDE, you should see the`trident` instance<br>under the`tridentorchestrators` CRD.<br> <br>|



Installing Trident M2-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-4**|Review the details by double-clicking the`trident` entry in the hierarchy, or use the following<br>command:<br>**`kubectl -n trident describe torc trident `**|
|**2-5**|Answer the following question:<br>In the`events` section, what is the last event type and reason?|
|**2-6**|Verify that you created all objects:<br>**`kubectl -n trident get all`**<br>Sample output:<br>`NAME                   READY  STATUS  RESTARTS   AGE`<br>`pod/trident-controller-74698976f5-5d2tz  6/6   Running  0       3m16s`<br>`pod/trident-node-linux-8t2tp       2/2   Running  2 (60s ago)  3m16s`<br>`pod/trident-node-linux-dnbm6       2/2   Running  2 (77s ago)  3m16s`<br>`pod/trident-node-linux-k29t7       2/2   Running  2 (76s ago)  3m16s`<br>`pod/trident-node-linux-td97m       2/2   Running  2 (71s ago)  3m16s`<br>`pod/trident-operator-5c94fc5556-nlsnl   1/1   Running  0       13h`<br> <br>`NAME         TYPE    CLUSTER-IP   EXTERNAL-IP  PORT(S)`<br>`service/trident-csi  ClusterIP  10.102.83.55  <none>    34571/TCP,9220/TCP  3`<br> <br>`NAME                DESIRED  CURRENT  READY  UP-TO-DATE  AVAIL`<br>`daemonset.apps/trident-node-linux  4     4     4    4      4`<br> <br>`NAME                 READY  UP-TO-DATE  AVAILABLE  AGE`<br>`deployment.apps/trident-controller  1/1   1      1      3m16s`<br>`deployment.apps/trident-operator   1/1   1      1      13h`<br> <br>`NAME                      DESIRED  CURRENT  READY  AGE`<br>`replicaset.apps/trident-controller-74698976f5  1     1     1    3m16s`<br>`replicaset.apps/trident-operator-5c94fc5556   1     1     1    13h `|
|**2-7**|The DaemonSet`trident-node-linux` creates the four`trident-node-linux` <br>pods. One`trident-node-linux` pod is installed on each node (including the<br>control-plane master node). The`trident-controller` deployment creates the<br>`trident-controller` pod, which runs on one of the worker nodes.|
|**2-8**|Stop the deployed Trident pods by deleting the`TridentOrchestrator` CR:<br>**`kubectl -n trident delete torc trident` **|
|**2-9**|Verify that every pod with`node`or` controller` in its name is deleted and that only the<br>Trident operator is running:<br>**`kubectl -n trident get pods -o wide`**|
|**2-10**|The`TridentOrchestrator` CR enables you to customize the Trident operator.<br>See the following URL for more details:https://docs.netapp.com/us-en/trident/trident-<br>get-started/kubernetes-customize-deploy.html. <br>The “crds” subfolder contains several examples of modifications.|
|**2-11**|<br>Try to run Trident only on Worker 1 and Worker 3.|


Installing Trident M2-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-12**|Create labels on two worker nodes:<br>**`kubectl label node kubwor1-1 storage=trident`**<br>**`kubectl label node kubwor1-3 storage=trident`**|
|**2-13**|Edit the deploy/crds/tridentorchestrator_cr.yaml file to add an appropriate toleration:<br>• <br>Definition:**nodePluginNodeSelector** (seehttps://docs.netapp.com/us-<br>en/trident/trident-get-started/kubernetes-customize-deploy.html)<br>• <br>Key:**storage**<br>• <br>Value:**trident** <br>You can find the solution for this step in the exercise2Task2-nodeselector.yaml file.|
|**2-14**|Create an instance of the`TridentOrchestrator` CR:<br>**`kubectl create -f [`****_`the edited .yaml file from the previous step`_****`] `**|
|**2-15**|After a few minutes, verify that the`trident` controller and node pods are only running on<br>kubwor1-1 and kubwor1-3:<br>**`kubectl -n trident get pods -o wide`**|
|**2-16**|Add the label to Worker 2:<br>**`kubectl label node kubwor1-2 storage=trident`**|
|**2-17**|Verify which nodes`trident` is running on:<br>**`kubectl -n trident get pods -o wide`**|
|**2-18**|CHALLENGE STEP: You can update an existing instance of the`trident` CR by using a<br>patch command. For example, if you want to turn off debug logs, use the following command:<br>**`kubectl -n trident patch torc trident --type=json /`**<br>**`      -p '[{"op": "replace", "path": "/spec/debug", "value": "false"}]' `**|
|**2-19**|CHALLENGE STEP: Verify that the debug logs are off.|
|**2-20**|Verify that the debug logs are on.|

##### **Task 3: Set up the tridentctl Tool**

The `tridentctl` tool was installed when you unzipped the `trident-installer` file.

|Step|Action|
|---|---|
|**3-1**|From the Exercise 2 folder, execute exercise2Task3.sh file from a terminal:<br> <br>**`./exercise2Task3.sh`**|



Installing Trident M2-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-2**|Review the`tridentctl` subcommands:<br>**`tridentctl`**<br> <br>Sample output:<br>`A CLI tool for managing the NetApp Trident external storage provisioner for Kubernetes`<br> <br>`Usage:`<br>` tridentctl [command]`<br> <br>`Available Commands:`<br>` completion Generate the autocompletion script for the specified shell`<br>` create   Add a resource to Trident`<br>` delete   Remove one or more resources from Trident`<br>` get     Get one or more resources from Trident`<br>` help    Help about any command`<br>` images   Print a table of the container images Trident needs`<br>` import   Import an existing resource to Trident`<br>` install   Install Trident`<br>` logs    Print the logs from Trident`<br>` send    Send a resource from Trident`<br>` uninstall  Uninstall Trident`<br>` update   Modify a resource in Trident`<br>` version   Print the version of Trident`<br> <br>`Flags:`<br>` -d, --debug        Set the log level to debug`<br>` -h, --help        help for tridentctl`<br>` -k, --kubeconfig string  Kubernetes config path`<br>`   --log-level string  Log level (trace, debug, warn, info, error, fatal (default "info")`<br>` -n, --namespace string  Namespace of Trident deployment`<br>` -o, --output string    Output format. One of json|yaml|name|wide|ps (default)`<br>` -s, --server string    Address/port of Trident REST interface (127.0.0.1 or [::1] only)`<br> <br>`Use "tridentctl [command] --help" for more information about a command.`|
|**3-3**|Verify which version of Trident is installed:<br>**`tridentctl -n trident version`**<br> <br>Sample output:<br>`+----------------+----------------+`<br>`| SERVER VERSION | CLIENT VERSION |`<br>`+----------------+----------------+`<br>`| 24.10.0    | 24.10.0    |`<br>`+----------------+----------------+`|
|**3-4**|See the images that are required for Trident to function, per the Kubernetes version:<br>**`tridentctl -n trident images`**<br> <br>Sample output:<br>`… `<br>`+--------------------+---------------------------------------------------------------+`<br>`| v1.31.0      | netapp/trident:24.10.0                    |`<br>`|          | docker.io/netapp/trident-autosupport:24.10          |`<br>`|          | registry.k8s.io/sig-storage/csi-provisioner:v5.1.0      |`<br>`|          | registry.k8s.io/sig-storage/csi-attacher:v4.7.0        |`<br>`|          | registry.k8s.io/sig-storage/csi-resizer:v1.12.0        |`<br>`|          | registry.k8s.io/sig-storage/csi-snapshotter:v8.1.0      |`<br>`|          | registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.12.0 |`<br>`|          | netapp/trident-operator:24.10.0 (optional)          |`<br>`+--------------------+---------------------------------------------------------------+`|


Installing Trident M2-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 4: Prepare worker nodes**

In this task, you verify that the worker nodes can use the volumes that Trident provides.

|Step|Action|
|---|---|
|**4-1**|Open a Secure Shell (SSH) session to Worker 1:<br>**`ssh root@192.168.0.62 `**|
|**4-2**|Verify that`nfs-common` is installed:<br>**`sudo apt list --installed | grep nfs-common `**|
|**4-3**|Verify that`open-iscsi`, `lsscsi`, and`scsitools` are installed:<br>**`sudo apt list --installed | grep scsi`**|
|**4-4**|Verify that`sg3-utils` is installed:<br>**`sudo apt list --installed | grep sg3`**|
|**4-5**|Verify that`multipath-tools` is installed:<br>**`sudo apt list --installed | grep multipath` **|
|**4-6**|Verify that`/etc/multipath.conf`has the following values :<br>`defaults {`<br>`  user_friendly_names yes`<br>`  find_multipaths no`<br>`}`|
|**4-7**|Enable multipathing:<br>**`sudo systemctl enable --now iscsid multipathd`**<br>NOTE: If you see an error, please ignore it.<br>**`sudo service iscsid restart`&&****` sudo service multipathd restart`**|
|**4-8**|Verify that`multipath-tools`and`iscsid` and are enabled and running:<br>**`sudo systemctl status multipathd iscsid`**|
|**4-9**|Verify your initiator node name:<br>**`cat /etc/iscsi/initiatorname.iscsi`**|
|**4-10**|Verify that`nvme-cli` is installed:<br>**`sudo apt list --installed | grep nvme`**|
|**4-11**|Scan the NVMe bus:<br>**`sudo modprobe nvme-tcp`**|
|**4-12**|Verify your NVMe Qualified Name (NQN):<br>**`cat /etc/nvme/hostnqn`**|
|**4-13**|Implement these steps across all nodes in the source and destination clusters:<br>**`./exercise2Task4.sh`**|



**End of exercise**


Installing Trident M2-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 3: Trident Configuration**

##### **Exercise 1: Working with Trident** **Objectives**

This exercise focuses on enabling you to do the following:


- Create a NAS back end

- Create a storage class for a NAS back end

- Provision a persistent volume claim with a NAS back end

- Mount the volumes in a pod

- Perform back-end management by using the `tridentctl` tool

- Perform back-end management by using the `kubectl` tool

- Configure customized naming conventions

- Create a NAS economy back end

- Provision NVMe namespaces using NetApp Trident

##### **Exercise Equipment**


In this exercise, you use the following systems.

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20 <br>|jumphost<br>|192.168.0.5<br>|user (case sensitive)<br>|Netapp1! <br>|
|Kubernetes Control Plane|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your Integrated Development Environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to have access to your Kubernetes clusters

- Create svm0

- Configure svm0 to use the NFS v3 protocol

- Install Trident in your source Kubernetes cluster

- Ensure iSCSI, NVMe and NFS are properly configured on your worker nodes in the source
Kubernetes cluster

##### **Task 1: Create a NAS back end**


In this task, you create a back end that uses ONTAP NAS storage driver. You can create many other
[back ends. For more information, see https://docs.netapp.com/us-en/trident/trident-use/backends.html.](https://docs.netapp.com/us-en/trident/trident-use/backends.html)
NOTE: When you unzip the `trident` tar file, the path `trident-installer/sample-inputs`
provides many examples of configuration files.

|Step|Action|
|---|---|
|**1-1**|To complete this task successfully, you must first complete Task 4 in the Module 1<br>exercise. In that task, you configure a storage VM (storage virtual machine, also<br>known as SVM) for the NFS protocol.|



Working with Trident M3-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-2**|If you are using terminal to execute kubectl commands, please change directories in your<br>terminal to Exercise 3 folder.|
|**1-3**|Modify the`exercise3Task1.json` file to add the appropriate settings:<br>• <br>Version:**`1` **<br>• <br>Storage driver name:**`ontap-nas`** <br>• <br>Back-end name:**`c1-svm0-nfs-tbe` **<br>• <br>Management LIF:**`192.168.0.30` **<br>• <br>Data LIF:**`192.168.0.31` **<br>• <br>SVM:**`svm0` **<br>• <br>Username:**`vsadmin`** <br>• <br>Password:**`Netapp1!`**|
|**1-4**|Save the JSON file.|
|**1-5**|The back-end definition is the only place that stores the credentials in plain text.<br>After you create the back end, usernames and passwords are encoded with Base<br>64 and stored as Kubernetes secrets. Creating and updating a back end are the<br>only operations that require knowledge of the credentials. These operations should<br>be admin-only.|
|**1-6**|Verify that you are in the working directory where the`tridentctl` tool and the back-end<br>JSON are present.|
|**1-7**|Create the back end by using the`tridentctl` tool:<br>**`tridentctl -n trident create backend -f exercise3Task1.json`**<br> <br>Sample output:<br>`+---------------------+----------------+--------------------------------------+--------+------------+--------+`<br>`|    NAME     | STORAGE DRIVER |         UUID         | STATE | USER-STATE | VOLUMES|`<br>`+---------------------+----------------+--------------------------------------+--------+------------+--------+`<br>`| c1-svm0-nfs-tbe   | ontap-nas   | 804a70a5-5959-435d-a9c7-6357230f2e13 | online | normal   |   0 |`<br>`+---------------------+----------------+--------------------------------------+--------+------------+--------+ `|
|**1-8**|Review the`tridentctl` logs:<br>**`tridentctl -n trident logs | tail -n 10` **|

##### **Task 2: Create a Storage Class for a NAS back end**

In this task, you create a storage class that uses the NAS back end that you created in Task 1.

|Step|Action|
|---|---|
|**2-1**|In your integrated development environment (IDE), open the`exercise3Task2.yaml` file.|
|**2-2**|Add the correct`backendType` to the parameters.<br>This value is the`storageDriverName` from the back-end JSON.|



Working with Trident M3-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-3**|Add the correct storagePools:~~**`"c1-svm0-nfs-tbe"`**~~and save the file.|
|**2-4**|Create the storage class:<br>**`kubectl create -f exercise3Task2.yaml` **|
|**2-5**|Verify that the storage class is created:<br>**`kubectl get sc c1-svm0-nfs-sc`**<br> <br>Sample output:<br>`NAME       PROVISIONER       RECLAIMPOLICY  VOLUMEBINDINGMODE  ALLOWVOLUMEEXPANSION  AGE`<br>`c1-svm0-nfs-sc  csi.trident.netapp.io  Delete     Immediate      false         37s`|
|**2-6**|Review the storage class by using the`tridentctl` tool:<br>**`tridentctl -n trident get storageclass c1-svm0-nfs-sc -o json`**<br> <br>Sample output:<br>`{ `<br>` "items": [`<br>`  {`<br>`   "Config": {`<br>`    "version": "1",`<br>`    "name": "c1-svm0-nfs-sc",`<br>`    "attributes": {`<br>`     "backendType": "ontap-nas"`<br>`    },`<br>`    "storagePools": null,`<br>`    "additionalStoragePools": null`<br>`   },`<br>`   "storage": {`<br>`    "c1-svm0-nfs-tbe": [`<br>`     "Cluster1_01_FC_1"`<br>`    ]`<br>`   }`<br>`  }`<br>` ]`<br>`} `|

##### **Task 3: Provision a Persistent Volume Claim with a NAS back end**

In this task, you create a persistent volume claim (PVC) for a volume that uses the storage class that
you created.

|Step|Action|
|---|---|
|**3-1**|In your IDE, open the`exercise3Task3.yaml` file.|
|**3-2**|Update the`storageClassName` with the name of the storage class that you created in the<br>previous task, and then save the file.|
|**3-3**|Create the PVC for a pod to use later:<br>**`kubectl create -f exercise3Task3.yaml`**|



Working with Trident M3-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-4**|After a moment, verify that you created the PVC:<br>**`kubectl -n default get pvc c1-svm0-nfs-pvc-1`**<br>Sample output:<br>`NAME        STATUS  VOLUME       CAPACITY  ACCESS MODES  STORAGECLASS …`<br>`c1-svm0-nfs-pvc-1  Bound  pvc-bf08cf3c-1a31… 1Gi    RWO      c1-svm0-nfs-sc …`|
|**3-5**|Navigate to ONTAP System Manager, and see the new volume that Trident created:<br>https://192.168.0.101/sysmgr/v4/storage/volumes.|

##### **Task 4: Mount the volumes in a pod**

In this task, you create a NGINX pod that uses the persistent volume (PV) and creates a default
webpage in the PV. This task includes a challenge step that asks you to expose the pod by using a
NodePort service and then view your custom webpage.

|Step|Action|
|---|---|
|**4-1**|In your IDE, review the`exercise3Task4-1.yaml` file.|
|**4-2**|Set the`claimName` definition to the name of the PVC that you created in the previous task.|
|**4-3**|Save the file.|
|**4-4**|Create the pod to use the Trident volume:<br>**`kubectl create -f exercise3Task4-1.yaml`**|
|**4-5**|Verify that you created the pod:<br>**`kubectl -n default get pod nfs-pod`**|
|**4-6**|Connect to the pod:<br>**`kubectl -n default exec -it nfs-pod -- /bin/sh`**|
|**4-7**|View how the PVC is mounted in the container:<br>**`# df -h`**|
|**4-8**|Change the directory to the Trident persistent volume:<br>**`# cd /usr/share/nginx/html` **|
|**4-9**|Create an HTML file in the current directory:<br>**`# echo '<html><body>Hello [`****_`your name`_****`] using NFS</body></html>' > index.html` **|
|**4-10**|Use**Ctrl-D** to exit the container’s shell.|
|**4-11**|Create a NodePort service and view the webpage contains your custom message:<br>**`kubectl create -f exercise3Task4-2.yaml`**|



Working with Trident M3-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-12**|View the services:<br>**`kubectl -n default get services`**<br>Sample output:<br>`NAME     TYPE    CLUSTER-IP   EXTERNAL-IP  PORT(S)    AGE`<br>`kubernetes  ClusterIP  10.96.0.1   <none>    443/TCP    2d`<br>`nfs-web   NodePort  10.106.85.27  <none>    80:31319/TCP  4m39s`|
|**4-13**|Open a browser to one of the Kubernetes cluster node IP addresses and the NodePort<br>referenced in the previous step. For example:http://192.168.0.62:31319. You should see<br>your index.html page displayed in the browser. NOTE: Use HTTP.|

##### **Task 5: Perform Back-End management by using the tridentctl tool**

In this task, you investigate the `tridentctl` commands and delete the pod that hosted your custom
webpage. You then re-create the pod and notice that the persistent volume, which reattached to the
new pod and your custom webpage, has persisted.

|Step|Action|
|---|---|
|**5-1**|Install jQuery on your jumphost:<br>**`sudo apt install -y jq `**|
|**5-2**|Use the`tridentctl` tool to identify the storage class is mapped to the correct backend (for<br>your convenience, you can copy this command from the`exercise3Task5.txt` file):<br>**`tridentctl get backend -n trident -o json | jq '[.items[] | {backend: .name,`**<br>**`storageClasses: [.storage[].storageClasses]|unique}]'`** <br>Sample output:<br>`[ `<br>` {`<br>`  "backend": "c1-svm0-nfs-tbe",`<br>`  "storageClasses": [`<br>`   [`<br>`    "c1-svm0-nfs-sc"`<br>`   ]`<br>`  ]`<br>` }`<br>`]`|
|**5-3**|You can delete and update the back end by using the`tridentctl` tool. For more<br>information, seehttps://docs.netapp.com/us-en/trident/trident-<br>use/backend_ops_tridentctl.html#create-a-backend.|
|**5-4**|Delete the NFS-supported pod:<br>**`kubectl -n default delete pod nfs-pod`**|
|**5-5**|Investigate the logs and see if the volume was deleted when the pod was deleted:<br>**`tridentctl logs -n trident | tail -n 20 `**|
|**5-6**|Notice that the volume was just “unpublished” and answer the following questions: How would<br>you delete the volume automatically when you delete the pod? Does the PVC still exist? Also<br>notice the finalizer that is associated with the PVC.|



Working with Trident M3-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-7**|Navigate to ONTAP System Manager and notice that the volume that Trident created for the<br>NFS-based PVC is still there:https://192.168.0.101/sysmgr/v4/storage/volumes.|
|**5-8**|Re-create the pod to use the Trident NFS-provided volume:<br>**`kubectl create -f exercise3Task4-1.yaml`**|
|**5-9**|Display the webpage and verify the webpage contains your custom message.|
|**5-10**|<br>Do not destroy any objects. You use the objects in the next exercise.|

##### **Task 6: Perform Back-End management by using the kubectl tool**

Previously, you created a back end by using the `tridentctl` tool. In this task, you create a back end
by using the `TridentBackendConfig` custom resource (CR) with the credentials that are stored in a
Kubernetes secret. For this task, you create a new SVM with the iSCSI protocol configured. NOTE:
SVMs allow multiple protocols. You could add the iSCSI configuration to `svm0`, but you create another
SVM in this task to keep the two SVMs functionality separate. You also use the SVM administrator
( `vsadmin` ) and a separate management path for Trident to communicate with the SVMs.

|Step|Action|
|---|---|
|**6-1**|To create your SVM, use_either_ Method 1 (steps 6-2 through 6-11)_or_ Method 2<br>(steps 6-13 through 6-22).|
|**6-2**|Method 1: Review and execute the`exercise1Task4-1.yaml` file to create the gateway<br>operator. NOTE: If you already deployed the gateway operator back in Exercise 1 Task 4 Step<br>4-2, you should skip this step.|
|**6-3**|Method 1: Verify that you created the`gateway-system` namespace and that the operator pod<br>is running in that namespace.|
|**6-4**|Method 1: Review and execute the`exercise3Task6-1.yaml` file to create an SVM called<br>`svm1` with the defined protocol in ONTAP Cluster 1.  NOTE: Execute this file with a`kubectl`<br>`apply` command, otherwise, an error will occur stating that the cluster1 admin’s secret is<br>already created.|
|**6-5**|Method 1 CHALLENGE STEP: Review the logs of the`manager` container for the`gateway-`<br>`manager` deployment’s pod to see the gateway operator in action:<br>**`kubectl -n gateway-system logs gateway-operator-[`****_`unique id`_****`] -c manager`**|
|**6-6**|Method 1: Open a browser and go to**https://192.168.0.101/** <br>(which is your Cluster1 management LIF’s address).|
|**6-7**|Method 1: For now, use the standard System Manager. Click the link:**Not now. Sign in to**<br>**System Manager.**Skip this step if you already have selected System Manager instead of<br>using NetApp BlueXP.|



Working with Trident M3-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-8**|Method 1: Authenticate with your ONTAP cluster by providing the following credentials:<br>• <br>Login as:**admin** <br>• <br>Password:** Netapp1!**|
|**6-9**|Method 1: Click**Sign In**.|
|**6-10**|Method 1: From the left pane, navigate to**Storage > Storage VMs**.|
|**6-11**|Method 1: Review the settings of`svm1` and verify that iSCSI and NVMe/TCP are configured.<br>Also verify that the`Cluster1_01_FC_1` is an available local tier for this SVM.|
|**6-12**|Remember: Skip the following steps if you already executed Method 1 (steps 4-2<br>through 4-11).|
|**6-13**|Method 2: To create an SVM, open a browser tohttps://192.168.0.101 <br>(which is your Cluster 1 management LIF’s IP address).|
|**6-14**|Method 2: Authenticate with your ONTAP cluster by providing the following credentials:<br>• <br>Login:**admin** <br>• <br>Password:**Netapp1!**|
|**6-15**|Method 2: Click**Sign In**.|
|**6-16**|Method 2: From the left pane, navigate to**Storage > Storage VMs**.|
|**6-17**|Method 2: Click**Add** to start the wizard to create an SVM.|


Working with Trident M3-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-18**|Method 2: Enter the following information, and then click**Save**. <br>• <br>SVM name:**svm1** <br>• <br>Select the**iSCSI**tab.<br>• <br>Access protocol: Select**Enable iSCSI** <br>• <br>Under Network Interface 1:<br>`o` IP address:**192.168.0.41** <br>`o` Subnet mask:**255.255.255.0** <br>`o` Broadcast domain:**Default** <br>`o` Select**Use the same subnet mask, gateway, and broadcast domain**<br>• <br>Under Network Interface 2:<br>IP Address:** 192.168.0.42**<br>• <br>Select the**NVMe**tab.<br>• <br>Access protocol: Select**NVMe/TCP** <br>• <br>Under Network Interface 1:<br>`o` IP Address:**192.168.0.43** <br>`o` Subnet mask:**255.255.255.0** <br>`o` Broadcast domain:**Default** <br>`o` Select**Use the same subnet mask, gateway, and broadcast domain** <br>• <br>Under Network Interface 2:<br>IP Address:** 192.168.0.44**<br>• <br>Manage administrator account:**Selected** <br>`o` User name:**vsadmin** <br>`o` Password:**Netapp1!** <br>`o` Confirm password:**Netapp1!** <br>`o` Select**Add a network interface for storage VM management**<br> <br>IP address:**192.168.0.40** <br> <br>Subnet mask:**255.255.255.0**<br> <br>Broadcast domain:**Default**|
|**6-19**|Method 2: When you see`svm1` in the list of SVMs, click the new**svm1** link.|
|**6-20**|Method 2: When you see the Overview of the`svm1`, click the**Edit** button in the upper-right<br>corner.|
|**6-21**|Method 2: Select the “Resource Allocation” checkbox to prefer local tiers, and make sure that<br>`Cluster1_01_FC_1` is selected in the list of local tiers.|
|**6-22**|Method 2: Click**Save**.|
|**6-23**|This is the end of the SVM creation steps. You should now have a svm1 in cluster1.<br>You will now continue along with the setting up Trident to work with this SVM.|


Working with Trident M3-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-24**|Update the`exercise3Task6-2.yaml` file with the details of the iSCSI SVM:<br>• <br>User name:**vsadmin**<br>• <br>Password:**Netapp1!**<br>• <br>Management LIF:**192.168.0.40**<br>• <br>SVM:**svm1** <br>NOTE: Generally, you should not specify a Data LIF for block protocols, otherwise, multipath<br>would be disabled.|
|**6-25**|Save the changes.|
|**6-26**|Create the secret and the back end by using the`kubectl` tool:<br>**`kubectl create -f exercise3Task6-2.yaml`**|
|**6-27**|In the Kubernetes IDE extension, ensure you are in the trident namespace. Navigate to<br>**`Clusters > kubernetes-admin@kubernetes > Custom Resources >`**<br>**`tridentbackendconfigs > c1-svm1-iscsi-tbc`**.<br>This back end is the one that you created. The status should show the last operation status as<br>`success` and the phase as`bound`.|
|**6-28**|Verify that you created the back-end configuration:<br>**`kubectl -n trident get tbc -o wide`**|
|**6-29**|Get details on the back-end configuration that you created:<br>**`kubectl -n trident describe tbc c1-svm1-iscsi-tbc `**|
|**6-30**|Review and update the name of the back end in the YAML, and then create the storage class<br>in the`exercise3Task6-3.yaml` file:<br>**`kubectl create -f exercise3Task6-3.yaml`**|
|**6-31**|Review and update the storage class name in the YAML, and then create the PVC in<br>exercise3Task6`-4.yaml`: <br>**`kubectl create -f exercise3Task6-4.yaml`**|
|**6-32**|Navigate to ONTAP System Manager and see the new volume that Trident created:<br>https://192.168.0.101/sysmgr/v4/storage/volumes.|
|**6-33**|Navigate to the LUNs in ONTAP System Manager and see the new LUN that Trident created:<br>https://192.168.0.101/sysmgr/v4/storage/luns.|
|**6-34**|Review and update the claim name in the YAML, and then create the pod in the<br>`exercise3Task6-5.yaml` file:<br>**`kubectl create -f exercise3Task6-5.yaml`**|
|**6-35**|Verify that you created the pod:<br>**`kubectl -n default get pod san-pod` **|
|**6-36**|Connect to the pod:<br>**`kubectl -n default exec -it san-pod -- /bin/sh` **|


Working with Trident M3-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-37**|View how the PVC is mounted in the container:<br>**`# df -h`**|
|**6-38**|Change the directory to the Trident persistent volume:<br>**`# cd /usr/share/nginx/html` **|
|**6-39**|Create a file in this location:<br>**`# echo '<html><body>Hello [`****_`your name`_****`] using iSCSI</body></html>' > index.html` **|
|**6-40**|Use**Ctrl-D** to exit the container’s shell.|
|**6-41**|CHALLENGE STEP: Create a NodePort service and view the custom webpage. An example<br>of this can be found in`Solutions/exercise3Task6-6.yaml`.|
|**6-42**|CHALLENGE STEP: Delete the pod and verify that the LUN still exists.|
|**6-43**|CHALLENGE STEP: Re-create the pod and view the webpage that contains your custom<br>message.|
|**6-44**|<br>Do not destroy any objects. You use the objects in a later exercise.|

##### **Task 7: Configure customized naming conventions**

In this task, you will work with a custom naming convention for a new TridentBackendConfig definition.

|Step|Action|
|---|---|
|**7-1**|Within ONTAP System Manager, review the volumes names created by Trident by default.<br>Notice that default naming conventions for volumes looks something like this:<br>_trident_pvc_e018e7ab_a95b_4cb7_a366_85953d8fdec5._|
|**7-2**|Review the`exercise3Task7-1.yaml` file.<br>Notice the following:<br> <br>1. This single file creates a secret for cluster1’s admin credentials and then uses that secret<br>in TridentBackendConfig.<br>2. In the TridentBackendConfig (tbc), the name of the tbc object is different than the<br>backend. This is not necessary. We are just demonstrating that the tbc object and the<br>backend can be different.<br>3. The storageclass’ storagepools is linked to the backend name designated in the tbc<br>object.|



Working with Trident M3-E1-P10


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**7-3**|Edit and save the`exercise3Task7-1.yaml` file and replace the change_me in the following<br>locations:<br>• <br>nameTemplate:`'{{ .labels.cluster }}_{{ .volume.Namespace }}_{{`<br>`.volume.RequestName }}_{{ .config.BackendName }}'` <br>• <br>cluster:`Cluster1` <br> <br>Note the following:<br>1. The labels.cluster in the name template will map to Cluster1 that we defined in the<br>cluster label.<br>2. The volume namespace will be the persistent volume claim’s namespace while the<br>volume RequestName will be name of the persistent volume claim.<br>3. Finally, the TridentBackendConfig’s BackendName will be appended to the end of the<br>volume name.|
|**7-4**|Create the secret, TridentBackendConfig and storageclass:<br>**`kubectl create -f exercise3Task7-1.yaml`**|
|**7-5**|Next, create a pvc that uses the storageclass you created in this task by updating the<br>`change_me` field in`exercise3Task7-2.yaml` and then execute the file:<br>**`kubectl create -f exercise3Task7-2.yaml`**|
|**7-6**|Review the PVC and PV created by`exercise3Task7-2.yaml`.|
|**7-7**|Within ONTAP System Manager, discover the name of the volume created by<br>`exercise3Task7-2.yaml`.<br>NOTE: Trident automatically adds a suffix corresponding to a slice of the volume’s UUID (a part<br>of the volume.Name).|
|**7-8**|CHALLENGE STEP: Experiment adding or replacing the name template in the<br>TridentBackendConfig with other naming conventions such:<br>• <br>{{ .config.StoragePrefix }}<br>• <br>{{ slice .volume.Name }}<br>• <br>Additional labels|
|**7-9**|CHALLENGE STEP: Discover the ONTAP volume name in the persistent volume’s internal<br>name attribute.|
|**7-10**|CHALLENGE STEP: Discover the default storagePrefix value if the TridentBackend (tbe) object<br>has {} as the value config.storage[0].ontap_config.storagePrefix.<br>Try:<br> <br>**`kubectl -n trident get tbe [some_tbe] -o`**<br>**`jsonpath={".config.ontap_config.storage[0].defaults.nameTemplate"};echo`** <br>|


Working with Trident M3-E1-P11


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 8: Create a NAS economy back end**

In this task, you will create a TridentBackendConfig to provisions qtrees instead of volumes, a storage
class to use that backend configuration, and then a persistent volume claim to generate storage.

|Step|Action|
|---|---|
|**8-1**|Review and update the change_me field in`exercise3Task8-1.yaml`.|
|**8-2**|Create the secret, TridentBackendConfig and storageclass:<br>**`kubectl apply -f exercise3Task8-1.yaml`**|
|**8-3**|Next, create a pvc that uses the storageclass you created in this task by updating the<br>`change_me` field in`exercise3Task8-2.yaml` and then execute the file:<br>**`kubectl create -f exercise3Task8-2.yaml`**|
|**8-4**|Review the PVC and PV created by`exercise3Task8-2.yaml`.|
|**8-5**|Within ONTAP System Manager, the name of the volume created by`exercise3Task8-`<br>`2.yaml`. Notice the naming structure of the volume and the qtrees.|
|**8-6**|Create another persistent volume claim in`exercise3Task8-3.yaml`: <br>**`kubectl create -f exercise3Task8-3.yaml`**|
|**8-7**|Review the resulting qtree in ONTAP System Manager.|


##### **Task 9: Provision NVMe namespaces using Trident**


In this task, you create an NVMe back end and a storage class, and you use that storage class to
create a persistent volume for a pod. Previously, in Task 6, you configured `svm1` to serve the
NVMe/TCP protocol.

|Step|Action|
|---|---|
|**9-1**|Update the`exercise3Task9-1.yaml` file with the details of the NVMe functionality for`svm1` <br>by using the`ontap-san` storage driver:<br>• <br>Management LIF:**192.168.0.40**<br>• <br>SVM:**svm1**<br>• <br>sanType:** nvme**<br>• <br>useREST:** true**<br>**NOTE:**You created the credentials secret, c1-svm1-backend-secret, previously.|
|**9-2**|Save the changes.|
|**9-3**|Create the secret and the back end by using the`kubectl` tool:<br>**`kubectl create -f exercise3Task9-1.yaml`**|
|**9-4**|In the Kubernetes IDE extension, ensure you are in the trident namespace. Navigate to<br>**`Clusters > kubernetes-admin@kubernetes > Custom Resources >`**<br>**`tridentbackendconfigs > c1-svm1-nvme-tbc`.**<br>This back end is the one that you created. The status should show the last operation status as<br>`success` and the phase as`bound`.|



Working with Trident M3-E1-P12


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**9-5**|Verify that you created the back-end configuration:<br>**`kubectl -n trident get tbc -o wide`**|
|**9-6**|Get details on the back-end configuration that you created:<br>**`kubectl -n trident describe tbcc1-svm1-nvme-tbc`**|
|**9-7**|Review and update the name of the back end in the YAML, and then create the storage class<br>in the`exercise3Task9-2.yaml` file:<br>**`kubectl create -f exercise3Task9-2.yaml`**|
|**9-8**|Review and update the storage class name in the YAML, and then create the PVC in the<br>`exercise3Task9-3.yaml` file:<br>**`kubectl create -f exercise3Task9-3.yaml`**|
|**9-9**|Navigate to ONTAP System Manager and see the new volume that Trident created:<br>https://192.168.0.101/sysmgr/v4/storage/volumes.|
|**9-10**|Navigate to NVMe Namespaces in ONTAP System Manager and see the new namespace that<br>Trident created:https://192.168.0.101/sysmgr/v4/storage/nvmeNamespaces.|
|**9-11**|Review and update the claim name in the YAML, and then create the pod in the<br>`exercise3Task9-4.yaml` file:<br>**`kubectl create -f exercise3Task9-4.yaml`**|
|**9-12**|Verify that the pod was created successfully:<br>**`kubectl -n default get pod nvme-pod`**|
|**9-13**|CHALLENGE STEP: Expose the pod using a service and try to access it.|


**End of exercise**


Working with Trident M3-E1-P13


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 4: NetApp Trident Use Scenarios**

##### **Exercise 1: Managing storage using NetApp Trident**

In this exercise, you explore and manage point-in-time Snapshot copies of a persistent volume (PV).
You also expand a PV. You also import a volume (that NetApp NetApp Trident does not control) as a
PV that NetApp Trident manages. Finally, you will implement a multiple zone storage network.

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Manage Snapshot copies

- Restore Snapshot data

- Import an external Snapshot copy

- Expand volumes

- Import volumes

- Implement multiple zones storage network

##### **Exercise Equipment**


In this exercise, you use the following systems.

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Control Plane|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your Integrated Development Environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to have access to your Kubernetes clusters

- Create svm0 and svm1

- Configure svm0 to use the NFS v3 protocol

- Configure svm1 to use the iSCSI and NVMe protocols

- Install Trident in your source Kubernetes cluster

- Ensure iSCSI, NVMe and NFS are properly configured on your worker nodes in the source
Kubernetes cluster

- Create the following TBE: c1-svm0-nfs-tbe, c1-svm1-iscsi-tbe, c1-svm0-nfs-custom-tbe

- Create the following StorageClass: c1-svm0-nfs-sc, c1-svm1-iscsi-sc, c1-svm0-nfs-custom-sc

- Create the following PVCs: c1-svm0-nfs-pvc-1, c1-svm1-iscsi-pvc-1, c1-svm0-nfs-custom-pvc-1

- Provision the following PODs: nfs-pod, san-pod


Managing storage using NetApp Trident M4-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 1: Manage Snapshot copies**

In this task, you configure the required custom resource definitions (CRDs) to use point-in-time
Snapshot copies of volumes in Kubernetes. Then you create the snapshot controller.

|Step|Action|
|---|---|
|**1-1**|In your integrated development environment (IDE), make sure that you are in the`Exercise 4` <br>folder of the course contents.|
|**1-2**|Create the`volumeshapshotclass` CRD:<br>**`kubectl create -f exercise4Task1-1.yaml`**|
|**1-3**|Create the`volumesnapshotcontents` CRD:<br>**`kubectl create -f exercise4Task1-2.yaml `**|
|**1-4**|Create the`volumesnapshot` CRD:<br>**`kubectl create -f exercise4Task1-3.yaml` **|
|**1-5**|Create the service account, roles, and role bindings for the`snapshot-controller` in the<br>`kube-system` namespace:<br>**`kubectl create -f exercise4Task1-4.yaml` **|
|**1-6**|Create the`snapshot-controller` stateful set in the`kube-system` namespace:<br>**`kubectl create -f exercise4Task1-5.yaml `**|
|**1-7**|Create a`volumesnapshotclass` custom resource (CR) that points to the NetApp Trident<br>Container Storage Interface (CSI) driver:<br>**`kubectl create -f exercise4Task1-6.yaml`**<br>NOTE: The`deletionPolicy` can be`Delete` or`Retain`. When set to`Retain`, <br>the underlying physical snapshot on the storage cluster is retained even when the<br>`VolumeSnapshot` object is deleted.|
|**1-8**|Complete the snapshot definition in the`exercise4Task1-7.yaml` file, and then save the file.<br>Under spec:<br>• <br>volumeSnapshotClassName: [**_name of the_****_`snapshotclass` that you created_**] <br>• <br>source persistentVolumeClaimName: [**_name of the NFS-backed persistent volume_**<br>**_claim (PVC) that you created in the previous exercise_**]|
|**1-9**|Create a snapshot of the NFS-backed PVC that you created in the previous exercise:<br>**`kubectl create -f exercise4Task1-7.yaml`**|
|**1-10**|Verify that you created the snapshot:<br>**`kubectl get volumesnapshots`**<br>Sample output:<br>`NAME    READYTOUSE  SOURCEPVC … RESTORESIZE  SNAPSHOTCLASS      SNAPSHOTCONTENT`<br>`c1-svm0-n… true     c1-svm0-n … 272Ki     csi-snap-class     snapcontent-b6d… `|



Managing storage using NetApp Trident M4-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-11**|Describe the snapshot, and notice the`Ready to Use` parameter:<br>**`kubectl describe volumesnapshots c1-svm0-nfs-pvc-1-snap-1`**<br>Sample output:<br>`Name:     c1-svm0-nfs-pvc-1-snap-1`<br>`Namespace:  default`<br>`Labels:    <none>`<br>`Annotations: <none>`<br>`API Version: snapshot.storage.k8s.io/v1`<br>`Kind:     VolumeSnapshot`<br>`Metadata:`<br>` Creation Timestamp: 2024-11-19T20:43:52Z`<br>` Finalizers:`<br>`  snapshot.storage.kubernetes.io/volumesnapshot-as-source-protection`<br>`  snapshot.storage.kubernetes.io/volumesnapshot-bound-protection`<br>` Generation:    1`<br>` Resource Version: 205488`<br>` UID:        cff5a387-6d10-4616-a9c2-de6b9a9d268d`<br>`Spec:`<br>` Source:`<br>`  Persistent Volume Claim Name: c1-svm0-nfs-pvc-1`<br>` Volume Snapshot Class Name:   csi-snap-class`<br>`Status:`<br>` Bound Volume Snapshot Content Name: snapcontent-cff5a387-6d10-4616-a9c2-de6b9a9d268d`<br>` Creation Time:            2024-11-19T20:44:55Z`<br>` Ready To Use:            true`<br>` Restore Size:            272Ki`<br>`Events:`<br>` Type   Reason         Age  From         Message`<br>` ----   ------         ----  ----         -------`<br>` Warning GetSnapshotClassFailed 3m45s snapshot-controller Failed to get snapshot class with error`<br>`volumesnapshotclass.snapshot.storage.k8s.io "csi-snap-class" not found`<br>` Normal  CreatingSnapshot    2m44s snapshot-controller Waiting for a snapshot default/c1-svm0-`<br>`nfs-pvc-1-snap-1 to be created by the CSI driver.`<br>` Normal  SnapshotCreated     2m43s snapshot-controller Snapshot default/c1-svm0-nfs-pvc-1-`<br>`snap-1 was successfully created by the CSI driver.`<br>` Normal  SnapshotReady      2m43s snapshot-controller Snapshot default/c1-svm0-nfs-pvc-1-`<br>`snap-1 is ready to use.`|
|**1-12**|Use the following defintions to complete a PVC in the`exercise4Task1-8.yaml` file, and<br>then execute the YAML:<br>• <br>Metadata name:**c1-svm0-nfs-pvcsnap-1** <br>• <br>Spec:<br>`o` accessModes:**ReadWriteOnce** <br>`o` resource requests storage:**1Gi** <br>`o` storageClassName:**c1-svm0-nfs-sc** <br>`o` dataSource:<br> <br>name:**c1-svm0-nfs-pvc-1-snap-1** <br> <br>kind:**VolumeSnapshot** <br> <br>apiGroup:**snapshot.storage.k8s.io**|
|**1-13**|Verify that you created the PVC:<br>**`kubectl get pvc`**<br>Sample output:<br>`NAME         STATUS  VOLUME    CAPACITY  ACCESS MODES  STORAGECLASS  VOLUMEATTRIBUT…`<br>`… `<br>`c1-svm0-nfs-pvc-1   Bound   pvc-5ea27d4 1Gi    RWO      c1-svm0-nfs-sc <unset>`<br>`c1-svm0-nfs-pvcsnap-1 Bound   pvc-af67c22 1Gi    RWO      c1-svm0-nfs-sc <unset>`<br>`… `|


Managing storage using NetApp Trident M4-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-14**|Describe the PVC that you created:<br>**`kubectl describe pvc c1-svm0-nfs-pvcsnap-1`**|
|**1-15**|NOTE: For this operation of creating a PVC based upon an ONTAP Snapshot copy,<br>the ONTAP cluster requires a NetApp FlexClone license. The PVC status would be<br>pending until you install the FlexClone license.|
|**1-16**|Create a pod manifest similar to`exercise3Task4-1.yaml`, name the new definition<br>**`exercise4Task1-9.yaml`**, and enter the following attributes:<br>• <br>Metadata name:**nfs-snap-pod** <br>• <br>Metadata label: app:**nfs-snap-web** <br>• <br>Spec volumes persistentVolumeClaim claimName:**nfs-snap** <br>Execute the new pod definition.|
|**1-17**|CHALLENGE STEP: Create a NodePort and view your custom webpage. If desired, you can<br>change the custom webpage to differentiate it from the previous exercise’s NFS-backed pod.<br>See exercise4Task1-10.yaml for assistance.|
|**1-18**|CHALLENGE STEP: Repeat Steps 1-8 through 1-16 for the SAN-backed PVC and pod. You<br>can find solutions in the exercise4Task1-11.yaml through exercise4Task1-14.yaml files.|

##### **Task 2: Restore Snapshot data**

In this task, you will restore snapshot data of a NFS-attached persistent volume. Take note that in the
`exercise3Task3.yaml` file, there is an annotation that reveals the snapshot directory, which is not
visible by default.

|Step|Action|
|---|---|
|**2-1**|Identify the name of PV volume used for the PVC of the nfs-pod.|
|**2-2**|Verify that the nfs-pod still exists:<br>**`kubectl -n default get pod nfs-pod`**<br>**NOTE:**If it doesn’t exists, please recreated by using`exercise3Task4-1.yaml file.`|
|**2-3**|Verify that the nfs-web service still exists:<br>**`kubectl -n default get services nfs-web`**<br>**NOTE:**If it doesn’t exists, please recreated by using`exercise3Task4-2.yaml file.`|
|**2-4**|Open a browser to one of the Kubernetes cluster node IP addresses and the NodePort<br>referenced in the previous step. For example:http://192.168.0.62:31319. You should see you<br>index.html you created previously in the browser.|
|**2-5**|Connect to the pod:<br>**`kubectl -n default exec -it nfs-pod -- /bin/sh`**|
|**2-6**|Change the directory to the Trident persistent volume:<br>**`# cd /usr/share/nginx/html` **|



Managing storage using NetApp Trident M4-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-7**|Update file in the current directory:<br>**`# echo '<html><body>Creating the file</body></html>' > index.html` **|
|**2-8**|Display the webpage and verify the webpage contains your updated message using the<br>nodeport service.|
|**2-9**|Create another snapshot with containing the newly created index.html file:<br>**`kubectl create -f exercise4Task2.yaml`**|
|**2-10**|Update file in the current directory:<br>**`# echo '<html><body>Updating the file</body></html>' > index.html`**|
|**2-11**|Display the webpage and verify the webpage contains your updated message using the<br>nodeport service.|
|**2-12**|List the hidden snapshot directory in the**`/usr/share/nginx/html`** path:<br>**`# ls .snapshot`**<br>Sample output:<br>**`snapshot-49593425-ece8-4874-9e1c-733d7218ae2d`**|
|**2-13**|Change directory into the Snapshot copy created in the previous task (your snapshot name will<br>vary):<br>**`# cd .snapshot/snapshot-49593425-ece8-4874-9e1c-733d7218ae2d`**|
|**2-14**|Verify you have access to the previous version of the index.html:<br>**`# cat index.html`**<br>NOTE: The original message should be in the html page:**`Creating the file.`**|
|**2-15**|Copy the previous version to the active file system:<br>**`# cp index.html ../../index.html`**|
|**2-16**|Verify the webpage as updated to the first custom message.|
|**2-17**|CHALLENGE STEP: Change the message again in the index.html file. Restore the entire<br>volume using Snapshot restore.|

##### **Task 3: Import an external Snapshot copy**

In this task, you will import a snapshot copy taken outside of Trident and provide it as volume snapshot
in the Kubernetes cluster.

|Step|Action|
|---|---|
|**3-1**|Using System Manager or the ONTAP CLI, create a snapshot named snap.1 for<br>Cluster1_default_c1_svm0_nfs-custom_pvc_1_c1_svm0_nfs_custom_tbe_[unique id] volume.|
|**3-2**|In the`exercise4Task3-1.yaml` file, replace the change_me in the snapshotHandle field<br>with the name of the Persistent Volume (PV) associated with volume used in the previous step.|



Managing storage using NetApp Trident M4-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-3**|Create the`volumeshapshotContents`: <br>**`kubectl create -f exercise4Task3-1.yaml` **|
|**3-4**|Create the`volumesnapshot`: <br>**`kubectl create -f exercise4Task3-2.yaml` **|
|**3-5**|CHALLENGE STEP: Create a PVC that uses the volumesnapshot created in the previous<br>step.|

##### **Task 4: Expand volumes**

In this task, you edit the storage class definitions for the NFS-backed storage class to enable volume
expansion, and then you expand the NFS-backed PV. This task includes a challenge step to perform
the same operation for the SAN-backed storage class and PV.

|Step|Action|
|---|---|
|**4-1**|Edit the`exercise4Task4-1.yaml` file, add the~~**`allowVolumeExpansion: true`**~~ <br>definition, and save the file.|
|**4-2**|Apply the updated definition:<br>**`kubectl apply -f exercise4Task4-1.yaml`**<br>Alternatively, you can use the command: **`kubectl edit sc c1-svm0-nfs-sc` **|
|**4-3**|Identify the PVC that the NFS-backed pod uses:<br>**`kubectl get pvc`**|
|**4-4**|Describe the PVC that the NFS-backed pod uses:<br>**`kubectl describe pvc c1-svm0-nfs-pvc-1`**|
|**4-5**|Identify the PV that the NFS-backed pod uses:<br>**`kubectl get pv`**|



Managing storage using NetApp Trident M4-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-6**|Describe the PV that the NFS-backed pod uses:<br>**`kubectl describe pv [name of the pv that is associated with nfs-basic claim]`**<br>Sample output:<br>`Name:      pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`Labels:     <none>`<br>`Annotations:   pv.kubernetes.io/provisioned-by: csi.trident.netapp.io`<br>`         volume.kubernetes.io/provisioner-deletion-secret-name:`<br>`         volume.kubernetes.io/provisioner-deletion-secret-namespace:`<br>`Finalizers:   [external-provisioner.volume.kubernetes.io/finalizer kubernetes.io/pv-protection`<br>`external-attacher/csi-trident-netapp-io]`<br>`StorageClass:  c1-svm0-nfs-sc`<br>`Status:     Bound`<br>`Claim:      default/c1-svm0-nfs-pvc-1`<br>`Reclaim Policy: Delete`<br>`Access Modes:  RWO`<br>`VolumeMode:   Filesystem`<br>`Capacity:    1Gi`<br>`Node Affinity:  <none>`<br>`Message:`<br>`Source:`<br>`  Type:       CSI (a Container Storage Interface (CSI) volume source)`<br>`  Driver:      csi.trident.netapp.io`<br>`  FSType:`<br>`  VolumeHandle:   pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`  ReadOnly:     false`<br>`  VolumeAttributes:   backendUUID=0ac9e971-8cad-4e54-bc0b-67fe354c8032`<br>`              internalName=trident_pvc_3ad39c72_d55a_4b01_9700_77591dcc3c1f`<br>`              name=pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`              protocol=file`<br>`              storage.kubernetes.io/csiProvisionerIdentity=1731956479128-2195-`<br>`csi.trident.netapp.io`<br>`Events:        <none> `|
|**4-7**|Edit the NFS-backed PVC in the`exercise4Task4-2.yaml` file, change the storage<br>definition from`1Gi` to**`2Gi`**, and save the file.|
|**4-8**|Apply the updated definition of the PVC:<br>**`kubectl apply -f exercise4Task4-2.yaml `**|
|**4-9**|Verify that the NFS-backed pod uses the expanded volume of the PVC:<br>**`kubectl describe pvc c1-svm0-nfs-pvc-1`**<br>Sample output:<br>`Name:     c1-svm0-nfs-pvc-1`<br>`Namespace:   default`<br>`StorageClass: c1-svm0-nfs-sc`<br>`Status:    Bound`<br>`Volume:    pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`Labels:    <none>`<br>`Annotations:  pv.kubernetes.io/bind-completed: yes`<br>`        pv.kubernetes.io/bound-by-controller: yes`<br>`        volume.beta.kubernetes.io/storage-provisioner: csi.trident.netapp.io`<br>`        volume.kubernetes.io/storage-provisioner: csi.trident.netapp.io`<br>`Finalizers:  [kubernetes.io/pvc-protection]`<br>`Capacity:   2Gi`<br>`Access Modes: RWO`<br>`VolumeMode:  Filesystem`<br>`Used By:    nfs-pod`<br>`Events:`<br>` Type   Reason         Age  From                  Message`<br>` ----   ------         ---- ----                  -------`<br>` Normal  Resizing        36s  external-resizer csi.trident.netapp.io External resizer is`<br>`resizing volume pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>` Warning ExternalExpanding    36s  volume_expand              waiting for an`<br>`external controller to expand this PVC`<br>` Normal  VolumeResizeSuccessful 36s  external-resizer csi.trident.netapp.io Resize volume`<br>`succeeded`|


Managing storage using NetApp Trident M4-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-10**|Describe the PV that the NFS-backed pod uses:<br>**`kubectl describe pv [name of the pv that is associated with nfs-basic claim]`**<br>Sample output:<br>`Name:      pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`Labels:     <none>`<br>`Annotations:   pv.kubernetes.io/provisioned-by: csi.trident.netapp.io`<br>`         volume.kubernetes.io/provisioner-deletion-secret-name:`<br>`         volume.kubernetes.io/provisioner-deletion-secret-namespace:`<br>`Finalizers:   [external-provisioner.volume.kubernetes.io/finalizer kubernetes.io/pv-`<br>`protection external-attacher/csi-trident-netapp-io]`<br>`StorageClass:  c1-svm0-nfs-sc`<br>`Status:     Bound`<br>`Claim:      default/c1-svm0-nfs-pvc-1`<br>`Reclaim Policy: Delete`<br>`Access Modes:  RWO`<br>`VolumeMode:   Filesystem`<br>`Capacity:    2Gi`<br>`Node Affinity:  <none>`<br>`Message:`<br>`Source:`<br>`  Type:       CSI (a Container Storage Interface (CSI) volume source)`<br>`  Driver:      csi.trident.netapp.io`<br>`  FSType:`<br>`  VolumeHandle:   pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`  ReadOnly:     false`<br>`  VolumeAttributes:   backendUUID=0ac9e971-8cad-4e54-bc0b-67fe354c8032`<br>`              internalName=trident_pvc_3ad39c72_d55a_4b01_9700_77591dcc3c1f`<br>`              name=pvc-3ad39c72-d55a-4b01-9700-77591dcc3c1f`<br>`              protocol=file`<br>`              storage.kubernetes.io/csiProvisionerIdentity=1731956479128-2195-`<br>`csi.trident.netapp.io`<br>`Events:        <none>`|
|**4-11**|CHALLENGE STEP: Repeat Steps 4-1 through 4-10 for the SAN-backed PVC and pod. You<br>can find solutions in the`exercise4Task4-3.yaml` through`exercise4Task4-4.yaml` <br>files.|
|**4-12**|<br>Two scenarios exist for resizing an iSCSI PV:<br> <br>• <br>If the PV is attached to a pod, NetApp Trident expands the volume on the storage back<br>end, rescans the device, and resizes the file system.<br>• <br>If the PV is not attached to a pod, NetApp Trident also expands the volume on the<br>storage back end. Then, after the PVC binds to a pod, NetApp Trident rescans the<br>device and resizes the file system. After the expand operation finishes successfully,<br>Kubernetes updates the PVC size.|

##### **Task 5: Import volumes**

In this task, you create a FlexClone volume of the NFS volume that you created in the previous
exercise. You then import the cloned volume as a PV and associate it with a PVC. This task includes a
challenge step to complete this activity with the LUN that you created in the previous exercise.

|Step|Action|
|---|---|
|**5-1**|Log in to ONTAP System Manager:https://192.168.0.101.|



Managing storage using NetApp Trident M4-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-2**|Authenticate with your ONTAP cluster by providing the following credentials:<br>• <br>Login as:**admin** <br>• <br>Password:**Netapp1!**|
|**5-3**|Navigate to**Storage** >**Volumes**.|
|**5-4**|Select the NetApp Trident volumes that is associated with the PVC**` c1-svm0-nfs-pvc-1`**.|
|**5-5**|Click the three vertical dots next to the volume’s name and select**Clone** from the menu.<br>|
|**5-6**|In the Clone Volume dialog box, provide the following details, and then click**Clone**. <br>• <br>Name:**import_vol** <br>• <br>Enable thin provisioning:**Selected** <br>• <br>Clone Parent Snapshot Copy:**Add a Snapshot Copy**|
|**5-7**|Verify that you created the new volume. If desired, you can split the clone.|
|**5-8**|Return to your IDE, open and review the`exercise4Task5-1.yaml` file, and ensure that the<br>storage size equals the size of the cloned volume that you created in the previous steps and<br>that you selected an appropriate storageclass.|
|**5-9**|Open a terminal in your IDE and ensure that the`exercise4Task5-1.yaml` file and the<br>`tridentctl` tool are in the same directory.|
|**5-10**|Identify the existing NFS back end by using the`tridentctl` tool and the`ontap-nas` driver:<br>**`tridentctl -n trident get backends`**|
|**5-11**|Create the back end by using the`tridentctl` tool:<br>**`tridentctl -n trident import volume c1-svm0-nfs-tbe import_vol -f`**<br>**`exercise4Task5-1.yaml`**<br>Sample output:<br>`+-----------------------------------------------------------------------------------+`<br>`|  NAME    | SIZE  | STORAGE CLASS | PROTOCOL | BACKEND… | STATE | MANAGED |`<br>`+-----------------------------------------------------------------------------------+`<br>`| pvc-b426a747… | 2.0 GiB | c1-svm0-nfs-sc | file   | 0ac9e971…| online | true  |`<br>`+-----------------------------------------------------------------------------------+`<br> <br>NOTE: Trident will rename the importing volume.|
|**5-12**|Identify the PVC that you created for the imported volume:<br>**`kubectl get pvc`**|


Managing storage using NetApp Trident M4-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-13**|Describe the PV that the NFS-backed pod uses:<br>**`kubectl describe pvc c1-svm0-nfs-import-pvc-1`**<br>Sample output:<br>`Name:     c1-svm0-nfs-import-pvc-1`<br>`Namespace:   default`<br>`StorageClass: c1-svm0-nfs-sc`<br>`Status:    Bound`<br>`Volume:    pvc-b426a747-0b57-446e-bf08-edfae2fbfe3d`<br>`Labels:    <none>`<br>`Annotations:  pv.kubernetes.io/bind-completed: yes`<br>`        pv.kubernetes.io/bound-by-controller: yes`<br>`        trident.netapp.io/importBackendUUID: 0ac9e971-8cad-4e54-bc0b-67fe354c8032`<br>`        trident.netapp.io/importOriginalName: import_vol`<br>`        trident.netapp.io/notManaged: false`<br>`        volume.beta.kubernetes.io/storage-provisioner: csi.trident.netapp.io`<br>`        volume.kubernetes.io/storage-provisioner: csi.trident.netapp.io`<br>`Finalizers:  [kubernetes.io/pvc-protection]`<br>`Capacity:   2Gi`<br>`Access Modes: RWO`<br>`VolumeMode:  Filesystem`<br>`Used By:    <none>`<br>`Events:`<br>` Type  Reason         Age        From                                              Message`<br>` ----  ------         ----        ----                                              -------`<br>` Normal Provisioning      59s        csi.trident.netapp.io_trident-controller-66b97d5f8d-xpm8g_627c21a4-0dd7-45e9-ace9-f95c027430ac External provisioner is provisioning volume`<br>`for claim "default/c1-svm0-nfs-import-pvc-1"`<br>` Normal ExternalProvisioning  59s (x2 over 59s) persistentvolume-controller                                   Waiting for a volume to be created either by`<br>`the external provisioner 'csi.trident.netapp.io' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.`<br>` Normal ProvisioningSuccess  58s        csi.trident.netapp.io                                      provisioned a volume`<br>` Normal ProvisioningSucceeded 58s        csi.trident.netapp.io_trident-controller-66b97d5f8d-xpm8g_627c21a4-0dd7-45e9-ace9-f95c027430ac Successfully provisioned volume pvc-`<br>`b426a747-0b57-446e-bf08-edfae2fbfe3d `|
|**5-14**|Identify the PV that the`nfs-import` claim uses:<br>**`kubectl get pv`**|
|**5-15**|Describe the PV that the`nfs-import` claim uses:<br>**`kubectl describe pv [name of the pv that is associated with nfs-import claim]`**<br>Sample output:<br>`Name:      pvc-b426a747-0b57-446e-bf08-edfae2fbfe3d`<br>`Labels:     <none>`<br>`Annotations:   pv.kubernetes.io/provisioned-by: csi.trident.netapp.io`<br>`         volume.kubernetes.io/provisioner-deletion-secret-name:`<br>`         volume.kubernetes.io/provisioner-deletion-secret-namespace:`<br>`Finalizers:   [external-provisioner.volume.kubernetes.io/finalizer kubernetes.io/pv-protection]`<br>`StorageClass:  c1-svm0-nfs-sc`<br>`Status:     Bound`<br>`Claim:      default/c1-svm0-nfs-import-pvc-1`<br>`Reclaim Policy: Delete`<br>`Access Modes:  RWO`<br>`VolumeMode:   Filesystem`<br>`Capacity:    2Gi`<br>`Node Affinity:  <none>`<br>`Message:`<br>`Source:`<br>`  Type:       CSI (a Container Storage Interface (CSI) volume source)`<br>`  Driver:      csi.trident.netapp.io`<br>`  FSType:`<br>`  VolumeHandle:   pvc-b426a747-0b57-446e-bf08-edfae2fbfe3d`<br>`  ReadOnly:     false`<br>`  VolumeAttributes:   backendUUID=0ac9e971-8cad-4e54-bc0b-67fe354c8032`<br>`              internalName=trident_pvc_b426a747_0b57_446e_bf08_edfae2fbfe3d`<br>`              name=pvc-b426a747-0b57-446e-bf08-edfae2fbfe3d`<br>`              protocol=file`<br>`              storage.kubernetes.io/csiProvisionerIdentity=1731956479128-2195-`<br>`csi.trident.netapp.io`<br>`Events:        <none>`|
|**5-16**|Create a pod to use the PVC for the imported volume:<br>**`kubectl create -f exercise4Task5-2.yaml`**|


Managing storage using NetApp Trident M4-E1-P10


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-17**|Create a service to use the pod for the imported volume:<br>**`kubectl create -f exercise4Task5-3.yaml `**|
|**5-18**|Connect to the pod:<br>**`kubectl -n default exec -it nfs-import-pod -- /bin/sh`**|
|**5-19**|Change the directory to the NetApp Trident PV:<br>**`# cd /usr/share/nginx/html`**|
|**5-20**|Attempt to edit the index.html file in your current directory:<br>**`# echo '<html><body>Hello [your name] using an imported volume</body></html>'`**<br>**`> index.html` **|
|**5-21**|Use**Ctrl-D** to break out of the`kubectl exec` operation.|
|**5-22**|Verify that the nfs-web service still exists:<br>**`kubectl -n default get services nfs-import-web`**|
|**5-23**|Open a web browser to the NodePort service and verify that you see the edited index.html<br>page.|
|**5-24**|CHALLENGE STEP: Complete this task by using a LUN-backed PV. You can find the solutions<br>in the`exercise4Task5-4.yaml` through`exercise4Task5-6.yaml` files.|

##### **Task 6: Implement multiple zones storage network**

In this task, you assume that you need to segment the nodes of your Kubernetes cluster into
subgroups. You create two different back ends. Each back end supports one of the Kubernetes worker
nodes. You use different storage in each subgroup (or zone). Zone 1 uses the NFS-based storage, and
Zone 2 uses the iSCSI-backed storage. To complete this task, you must appropriately label the worker
nodes in Module 2, Exercise 1, Task 1, steps 1-4 through 1-6. If you did not complete these previous
steps, you cannot complete this task.

|Step|Action|
|---|---|
|**6-1**|Create the back end for Zone 1 (NFS storage):<br>**`kubectl apply -f exercise4Task6-1.yaml` **|
|**6-2**|Create the back end for Zone 2 (iSCSI storage):<br>**`kubectl apply -f exercise4Task6-2.yaml`**|
|**6-3**|Create the storage class for Zone 1 (NFS storage):<br>**`kubectl apply -f exercise4Task6-3.yaml` **|
|**6-4**|Create the storage class for Zone 2 (iSCSI storage):<br>**`kubectl apply -f exercise4Task6-4.yaml` **|
|**6-5**|The`volumeBindingMode` setting is set to`WaitForFirstConsumer` (default value:<br>`Immediate`), which means that the PVC is not created until a pod references the PVC.|



Managing storage using NetApp Trident M4-E1-P11


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-6**|Verify the mappings are correct between the Trident backends and the storage classes:<br>**`tridentctl get backend -n trident -o json | jq '[.items[] | {backend: .name,`**<br>**`storageClasses: [.storage[].storageClasses]|unique}]'`**|
|**6-7**|Create a new namespace called`topology` and then create a PVC for Zone 1 (NFS storage):<br>**`kubectl apply -f exercise4Task6-5.yaml`**|
|**6-8**|Create a PVC for Zone 2 (iSCSI storage):<br>**`kubectl apply -f exercise4Task6-6.yaml` **|
|**6-9**|Investigate the PVCs, and answer the following question:<br>Are any matching PVs created? (Hint: Describe one of the PVC in the`topology` namespace.)|
|**6-10**|Create a pod for Zone 1 to use NAS storage:<br>**`kubectl apply -f exercise4Task6-7.yaml` **|
|**6-11**|Create a pod for Zone 2 to use SAN storage:<br>**`kubectl apply -f exercise4Task6-8.yaml` **|
|**6-12**|Investigate the PVCs, and answer the following question:<br>Are any matching PVs created? Check the PVC’s annotation volume.kubernetes.io/select-<br>node to verify that PVC was associated with the correct node.|
|**6-13**|CHALLENGE STEP: Add another back end, storageclass, PVC, and pod using NVMe for Zone<br>3.|


**End of exercise**


Managing storage using NetApp Trident M4-E1-P12


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 5: Protection**

##### **Exercise 1: Protecting Trident Workloads**

In this exercise, you install NetApp Trident Protect, configure a Simple Storage Service (S3) bucket as
an AppVault, and set up MySQL and WordPress sample applications. You also protect applications,
restore applications in a new namespace and in place. Finally, you install and use `tridentctl`
`protect` to manage Trident Protect.

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Install Trident Protect

- Configure storage for Trident Protect usage scenarios

- Set up sample applications

- Protect application data using Trident Protect custom resource

- Restore an application using Trident Protect custom resource

- Perform an in-place restore using Trident Protect custom resource

- Use `tridentctl protect` to manage Trident Protect

##### **Exercise Equipment**


In this exercise, you use the following systems.

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Control Plane|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your integrated development environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to access your Kubernetes clusters

- Install NetApp Trident in your source Kubernetes cluster

- Ensure that you properly configure iSCSI, NVMe, and NFS on your worker nodes in the source
Kubernetes cluster

- Add Container Storage Interface (CSI) snapshot support and a VolumeSnapshotClass

##### **Task 1: Install Trident Protect**


In this task, use Helm to install Trident Protect. To complete this task, you must first install the CSI
snapshot support from Module 4. Specifically, you must first run the files `exercise4Task1-1.yaml`
through `exercise4Task1-6.yaml` .

|Step|Action|
|---|---|
|**1-1**|From a terminal window, enter the following command:<br>**`sudo snap install helm --classic`**|



Protecting Trident Worloads M5-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-2**|When prompted, enter the user’s password.|
|**1-3**|Enter the following command to verify that Helm is installed properly:<br>**`helm`**<br> <br>Sample output:<br>`The Kubernetes package manager`<br> <br>`Common actions for Helm:`<br> <br>`- helm search:  search for charts`<br>`- helm pull:   download a chart to your local directory to view`<br>`- helm install:  upload the chart to Kubernetes`<br>`- helm list:   list releases of charts`<br> <br>`Environment variables:`<br> <br>`… `<br> <br>`Helm stores cache, configuration, and data based on the following configuration order:`<br> <br>`- If a HELM_*_HOME environment variable is set, it will be used`<br>`- Otherwise, on systems supporting the XDG base directory specification, the XDG variables will be used`<br>`- When no other location is set a default location will be used based on the operating system`<br> <br>`By default, the default directories depend on the Operating System. The defaults are listed below:`<br> <br>`| Operating System | Cache Path        | Configuration Path       | Data Path        |`<br>`|------------------|---------------------------|--------------------------------|-------------------------|`<br>`| Linux      | $HOME/.cache/helm     | $HOME/.config/helm       | $HOME/.local/share/helm |`<br>`| macOS      | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm   |`<br>`| Windows     | %TEMP%\helm        | %APPDATA%\helm         | %APPDATA%\helm     |`<br> <br>`Usage:`<br>` helm [command]`<br> <br>`Available Commands:`<br>` completion generate autocompletion scripts for the specified shell`<br>` create   create a new chart with the given name`<br>` dependency manage a chart's dependencies`<br>` env     helm client environment information`<br>` get     download extended information of a named release`<br>` help    Help about any command`<br>` history   fetch release history`<br>` install   install a chart`<br>` lint    examine a chart for possible issues`<br>` list    list releases`<br>` package   package a chart directory into a chart archive`<br>` plugin   install, list, or uninstall Helm plugins`<br>` pull    download a chart from a repository and (optionally) unpack it in local directory`<br>` push    push a chart to remote`<br>` registry  login to or logout from a registry`<br>` repo    add, list, remove, update, and index chart repositories`<br>` rollback  roll back a release to a previous revision`<br>` search   search for a keyword in charts`<br>` show    show information of a chart`<br>` status   display the status of the named release`<br>` template  locally render templates`<br>` test    run tests for a release`<br>` uninstall  uninstall a release`<br>` upgrade   upgrade a release`<br>` verify   verify that a chart at the given path has been signed and is valid`<br>` version   print the client version information`<br> <br>`Flags:`<br>`   --burst-limit int         client-side default throttling limit (default 100)`<br>`   --debug              enable verbose output`<br>` -h, --help              help for helm`<br>`   --kube-apiserver string      the address and the port for the Kubernetes API server`<br>`   --kube-as-group stringArray    group to impersonate for the operation, this flag can be repeated to specify multiple groups.`<br>`   --kube-as-user string       username to impersonate for the operation`<br>`   --kube-ca-file string       the certificate authority file for the Kubernetes API server connection`<br>`   --kube-context string       name of the kubeconfig context to use`<br>`   --kube-insecure-skip-tls-verify  if true, the Kubernetes API server's certificate will not be checked for validity.`<br>`   --kube-tls-server-name string   server name to use for Kubernetes API server certificate validation.`<br>`   --kube-token string        bearer token used for authentication`<br>`   --kubeconfig string        path to the kubeconfig file`<br>` -n, --namespace string        namespace scope for this request`<br>`   --qps float32           queries per second used when communicating with the Kubernetes API, not including bursting`<br>`   --registry-config string     path to the registry config file (default "/home/user/.config/helm/registry/config.json")`<br>`   --repository-cache string     path to the directory containing cached repository indexes (default "/home/user/.cache/helm/repository")`<br>`   --repository-config string    path to the file containing repository names and URLs (default "/home/user/.config/helm/repositories.yaml")`<br> <br>`Use "helm [command] --help" for more information about a command.`|
|**1-4**|Review the`exercise5Task1.sh` file and notice that this shell script performs the following<br>actions:<br>1. Creates a new namespace called`trident-protect` <br>2. Adds the NetApp GitHub repository to helm<br>3. Installs the`trident-protect` custom resource definitions<br>4. Installs the`trident-protect` image|


Protecting Trident Worloads M5-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-5**|Change the directory in a terminal to Exercise 5:<br>**`cd Exercise\ 5`**|
|**1-6**|Run the shell script from a terminal:<br>**`./exercise5Task1.sh`**|
|**1-7**|Verify that everything is running in the new`trident-protect` namespace:<br>**`kubectl -n trident-protect get all`**<br> <br>Sample output:<br>`NAME                           READY  STATUS  RESTARTS  AGE`<br>`pod/trident-protect-controller-manager-7b76c8b59f-zhb86  2/2   Running  0     54s`<br> <br>`NAME                             TYPE    CLUSTER-IP`<br>`EXTERNAL-IP  PORT(S)  AGE`<br>`service/tp-webhook-service                  ClusterIP  10.105.30.246  <none>`<br>`443/TCP  54s`<br>`service/trident-protect-controller-manager-metrics-service  ClusterIP  10.100.147.153  <none>`<br>`8443/TCP  54s`<br> <br>`NAME                         READY  UP-TO-DATE  AVAILABLE  AGE`<br>`deployment.apps/trident-protect-controller-manager  1/1   1      1      54s`<br> <br>`NAME                              DESIRED  CURRENT  READY  AGE`<br>`replicaset.apps/trident-protect-controller-manager-7b76c8b59f  1     1     1    54s`|
|**1-8**|Verify the new custom resource definitions that are associated with Trident Protect:<br>**`kubectl get crds | grep protect.trident`**<br> <br>Sample output:<br>`applications.protect.trident.netapp.io         2024-11-20T23:17:50Z`<br>`appmirrorrelationships.protect.trident.netapp.io    2024-11-20T23:17:50Z`<br>`appmirrorupdates.protect.trident.netapp.io       2024-11-20T23:17:50Z`<br>`appvaults.protect.trident.netapp.io          2024-11-20T23:17:50Z`<br>`autosupportbundles.protect.trident.netapp.io      2024-11-20T23:17:50Z`<br>`autosupportbundleschedules.protect.trident.netapp.io  2024-11-20T23:17:50Z`<br>`backupinplacerestores.protect.trident.netapp.io    2024-11-20T23:17:50Z`<br>`backuprestores.protect.trident.netapp.io        2024-11-20T23:17:50Z`<br>`backups.protect.trident.netapp.io           2024-11-20T23:17:50Z`<br>`exechooks.protect.trident.netapp.io          2024-11-20T23:17:50Z`<br>`exechooksruns.protect.trident.netapp.io        2024-11-20T23:17:50Z`<br>`kopiavolumebackups.protect.trident.netapp.io      2024-11-20T23:17:50Z`<br>`kopiavolumerestores.protect.trident.netapp.io     2024-11-20T23:17:50Z`<br>`pvccopies.protect.trident.netapp.io          2024-11-20T23:17:50Z`<br>`pvcerases.protect.trident.netapp.io          2024-11-20T23:17:50Z`<br>`resourcebackups.protect.trident.netapp.io       2024-11-20T23:17:50Z`<br>`resourcedeletes.protect.trident.netapp.io       2024-11-20T23:17:50Z`<br>`resourcerestores.protect.trident.netapp.io       2024-11-20T23:17:50Z`<br>`resticvolumebackups.protect.trident.netapp.io     2024-11-20T23:17:50Z`<br>`resticvolumerestores.protect.trident.netapp.io     2024-11-20T23:17:50Z`<br>`schedules.protect.trident.netapp.io          2024-11-20T23:17:50Z`<br>`shutdownsnapshots.protect.trident.netapp.io      2024-11-20T23:17:50Z`<br>`snapshotinplacerestores.protect.trident.netapp.io   2024-11-20T23:17:50Z`<br>`snapshotrestores.protect.trident.netapp.io       2024-11-20T23:17:50Z`<br>`snapshots.protect.trident.netapp.io          2024-11-20T23:17:50Z`|
|**1-9**|Change to the destination Kubernetes cluster (`exercise5Task2-3.txt`):<br>**`kubectl config use-context destination-admin@destination`**|
|**1-10**|Repeat 1-6 through 1-8 in the destination cluster.|


Protecting Trident Worloads M5-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 2: Configure storage for Trident Protect usage scenarios**

In this task, configure your `svmsrc` and `svmdst` storage VMs (storage virtual machines, also known
as SVMs). You will configure it with NFS, iSCSI, NVMe/TCP and S3 protocols. Finally, you will add a
bucket with the appropriate permissions and provide the configuration information to Trident Protect as
a backup location. The `svmsrc` SVM will be associated with the source Kubernetes cluster while the
`svmdst` SVM will be associated with destination Kubernetes cluster. This represents primary and
secondary sites. For your convenience, this task will use the Gateway operator
[(https://github.com/NetApp-Learning-Services/gateway) to configure your SVMs. Please note, the](https://github.com/NetApp-Learning-Services/gateway)
Gateway operator is not supported by NetApp and used for educational purposes only. Secrets will be
also created in each Kubernetes cluster to allow authentication to the S3 buckets. Finally, you will
create an AppVault for tp-src in the source Kubernetes cluster.

|Step|Action|
|---|---|
|**2-1**|Ensure you are in the source cluster (`exercise5Task2-1.txt`):<br>**`kubectl config use-context source-admin@source`**|
|**2-2**|Make sure that you have the Gateway operator installed in the source cluster:<br> **`kubectl create -f exercise5Task2-2.yaml`**<br>**NOTE:**If you have used the gateway operator method to create either svm0 or svm1, this step<br>maybe skipped. Please note, the Gateway operator is not supported by NetApp and used for<br>educational purposes only.|
|**2-3**|Ensure you are in the destination cluster (`exercise5Task2-3.txt`):<br>**`kubectl config use-context destination-admin@destination`**|
|**2-4**|Make sure that you have the Gateway operator installed in the destination cluster:<br> **`kubectl create -f exercise5Task2-2.yaml`**<br>**NOTE:** The Gateway operator is not supported by NetApp and used for educational purposes<br>only.|
|**2-5**|Ensure you are in the source cluster (`exercise5Task2-1.txt`):<br>**`kubectl config use-context source-admin@source`**|
|**2-6**|Review and create the source SVM:<br> **`kubectl create -f exercise5Task2-4.yaml`**|
|**2-7**|Ensure you are in the destination cluster (`exercise5Task2-3.txt`):<br>**`kubectl config use-context destination-admin@destination`**|
|**2-8**|Review and create the destination SVM:<br> **`kubectl create -f exercise5Task2-5.yaml`**|



Protecting Trident Worloads M5-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-9**|In System Manager or using ONTAP CLI for Cluster1, ensure the following:<br> <br>• <br>`svmsrc` is configured for the NFS and S3 protocols<br>• <br>NFS LIF has an IP address of 192.168.0.71<br>• <br>S3 user was created named`gateway-s3-src` <br>• <br>S3 LIF has an IP address of 192.168.0.74<br>• <br>S3 bucket`tp-src` was created<br>• <br>`tp-src`has following permissions: ListBucket, GetBucket, PutBucket, DeleteBucket<br>• <br>Cluster1 and Cluster2 are peered with`svmsrc` and`svmdst` peered by intercluster LIFs<br> <br>**NOTE:** Occasionally, the clusters do not complete the peering operation. If this occurs, you<br>can delete the cluster peer on either side and wait a few minutes for it to reestablish.|
|**2-10**|In the source Kubernetes cluster, you should now have a`gateway-s3-src` secret in<br>the Trident Protect namespace. The secret has the access key and secret key to<br>access the S3 bucket also created by**`exercise5Task2-4.yaml`**. This was created<br>by the Gateway operator when it created the S3 user.|
|**2-11**|In System Manager or using ONTAP CLI for Cluster2, ensure the following:<br> <br>• <br>`svmdst` is configured for the NFS and S3 protocols<br>• <br>NFS LIF has an IP address of 192.168.0.81<br>• <br>S3 user was created named`gateway-s3-dst` <br>• <br>S3 LIF has an IP address of 192.168.0.84<br>• <br>S3 bucket`tp-dst` was created<br>• <br>`tp-dst`has following permissions: ListBucket, GetBucket, PutBucket, DeleteBucket<br>• <br>Cluster1 and Cluster2 are peered with`svmsrc` and`svmdst` peered by intercluster LIFs<br> <br>**NOTE:** Occasionally, the clusters do not complete the peering operation. If this occurs, you<br>can delete the cluster peer on either side and wait a few minutes for it to reestablish.|
|**2-12**|In the destination Kubernetes cluster, you should now have a`gateway-s3-dst` <br>secret in the Trident Protect namespace. The secret has the access key and secret<br>key to access the S3 bucket also created by**`exercise5Task2-5.yaml`**. This was<br>created by the Gateway operator when it created the S3 user.|
|**2-13**|Install the`aws-cli` tool:<br>**`snap install aws-cli --classic`**|
|**2-14**|Execute the following script that will copy the`gateway-s3-src` secret from the source to the<br>destination Kubernetes cluster and also setup an aws configuration profile called`src` to<br>storage the credentials to the tp-src bucket:<br>**`./execise5Task2-6.sh`**|
|**2-15**|Execute the following script that will copy the`gateway-s3-dst` secret from the destination to<br>the source Kubernetes cluster and also setup an aws configuration profile called`dst` to<br>storage the credentials to the tp-dst bucket:<br>**`./execise5Task2-7.sh`**|


Protecting Trident Worloads M5-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**2-16**|List the empty bucket`tp-src` (`exercise5Task2-8.txt`):<br>**`aws --endpoint-url https://192.168.0.74 s3api list-objects-v2 --bucket`**<br>**`tp-src --no-verify-ssl --profile src`**|
|**2-17**|Review the`exercise5Task2-9.yaml` file that creates an AppVault, and verify that the<br>bucket name, endpoint, and credentials point to the correct values.|
|**2-18**|Create an AppVault in the source Kubernetes cluster:<br>**`kubectl create -f exercise5Task2-9.yaml`**|
|**2-19**|Verify that the state of the new AppVault is available:<br>**`kubectl -n trident-protect get appvault`**|
|**2-20**|Verify that the AppVault.json is now in the bucket (`exercise5Task2-8.txt`):<br>**`aws --endpoint-url https://192.168.0.74 s3api list-objects-v2 --bucket`**<br>**`tp-src --no-verify-ssl --profile src`**|
|**2-21**|Review and execute to create a source TridentBackendConfig, Secret, and StorageClass:<br>**`kubectl create -f exercise5Task2-10.yaml`**|


Protecting Trident Worloads M5-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 3: Set up sample applications**

You can now deploy several client applications. First deploy MySQL and then deploy a WordPress
application by using Helm. To complete these installations, a default storage class must exist.

|Step|Action|
|---|---|
|**3-1**|At the terminal, enter the following command to install mySQL (`exercise5Task3-1.txt`):<br>**`helm install mysqlapp oci://registry-1.docker.io/bitnamicharts/mysql`**<br>**`--version 12.0.0 --namespace mysqlapp --create-namespace`**<br>Sample output: <br>`NAME: mysqlapp`<br>`LAST DEPLOYED: Thu Nov 21 18:58:52 2024`<br>`NAMESPACE: mysqlapp`<br>`STATUS: deployed`<br>`REVISION: 1`<br>`TEST SUITE: None`<br>`NOTES:`<br>`CHART NAME: mysql`<br>`CHART VERSION: 12.0.0`<br>`APP VERSION: 8.4.3`<br> <br>`** Please be patient while the chart is being deployed **`<br> <br>`Tip:`<br> <br>` Watch the deployment status using the command: kubectl get pods -w --namespace mysqlapp`<br> <br>`Services:`<br> <br>` echo Primary: mysqlapp.mysqlapp.svc.cluster.local:3306`<br> <br>`Execute the following to get the administrator credentials:`<br> <br>` echo Username: root`<br>` MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace mysqlapp mysqlapp -o`<br>`jsonpath="{.data.mysql-root-password}" | base64 -d)`<br> <br>`To connect to your database:`<br> <br>` 1. Run a pod that you can use as a client:`<br> <br>`   kubectl run mysqlapp-client --rm --tty -i --restart='Never' --image`<br>`docker.io/bitnami/mysql:8.4.3-debian-12-r0 --namespace mysqlapp --env`<br>`MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash`<br> <br>` 2. To connect to primary service (read/write):`<br> <br>`   mysql -h mysqlapp.mysqlapp.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"`<br> <br>`WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not`<br>`recommended for production. For production installations, please set the following values`<br>`according to your workload needs:`<br>` - primary.resources`<br>` - secondary.resources`<br>`+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/`|
|**3-2**|This process takes about 90 seconds. You can watch the status:<br>**`kubectl -n mysqlapp get pods -w`**|
|**3-3**|You should now have a running instance of MySQL. You do not need to perform the<br>steps listed in the output of the Helm chart installation.|



Protecting Trident Worloads M5-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-4**|Install a second application (which you can find in`exercise5Task3-2.txt`): <br>**`helm install mywordpressapp bitnami/wordpress --version 24.0.6 --namespace`**<br>**`mywordpressapp --values=“exercise5Task3-3.yaml“ --create-namespace`**<br>Sample output:<br>`NAME: mywordpressapp`<br>`LAST DEPLOYED: Thu Nov 21 19:03:23 2024`<br>`NAMESPACE: mywordpressapp`<br>`STATUS: deployed`<br>`REVISION: 1`<br>`TEST SUITE: None`<br>`NOTES:`<br>`CHART NAME: wordpress`<br>`CHART VERSION: 24.0.6`<br>`APP VERSION: 6.7.0`<br> <br>`** Please be patient while the chart is being deployed **`<br> <br>`Your WordPress site can be accessed through the following DNS name from within your cluster:`<br> <br>`  mywordpressapp.mywordpressapp.svc.cluster.local (port 80)`<br> <br>`To access your WordPress site from outside the cluster follow the steps below:`<br> <br>`1. Get the WordPress URL by running these commands:`<br> <br>` NOTE: It may take a few minutes for the LoadBalancer IP to be available.`<br>`    Watch the status with: 'kubectl get svc --namespace mywordpressapp -w mywordpressapp'`<br> <br>`  export SERVICE_IP=$(kubectl get svc --namespace mywordpressapp mywordpressapp --template "{{`<br>`range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")`<br>`  echo "WordPress URL: http://$SERVICE_IP/"`<br>`  echo "WordPress Admin URL: http://$SERVICE_IP/admin"`<br> <br>`2. Open a browser and access WordPress using the obtained URL.`<br> <br>`3. Login with the following credentials below to see your blog:`<br> <br>` echo Username: admin`<br>` echo Password: $(kubectl get secret --namespace mywordpressapp mywordpressapp -o`<br>`jsonpath="{.data.wordpress-password}" | base64 -d)`<br> <br>`WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not`<br>`recommended for production. For production installations, please set the following values`<br>`according to your workload needs:`<br>` - resources`<br>`+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/`|
|**3-5**|This process takes about 90 seconds. You can watch the status:<br>**`kubectl -n mywordpressapp get pods -w`**|
|**3-6**|You should now have a running instance of WordPress. You do not need to perform<br>the steps listed in the output of the Helm chart installation.|
|**3-7**|Install the MetalLB load balancer:<br>**`kubectl create -f exercise5Task3-4.yaml`**|
|**3-8**|This process takes about 30 seconds. You can watch the status:<br>**`kubectl -n metallb-system get pods -w`**|
|**3-9**|When five MetalLB pods are running, apply the configuration with the IP range of<br>192.168.0.240-244:<br>**`kubectl create -f exercise5Task3-5.yaml` **|


Protecting Trident Worloads M5-E1-P8


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 4: Protect application data using Trident Protect custom resource**

In this task, create a Trident Protect application for the MySQL namespace that you created earlier.
Then create an on-demand snapshot, an on-demand backup, and a protection schedule.

|Step|Action|
|---|---|
|**4-1**|Review and create the application custom resource in`exercise5Task4-1.yaml`: <br>**`kubectl create -f exercise5Task4-1.yaml`**|
|**4-2**|Ensure that you created the application and that the ready status is true:<br>**`kubectl -n mysqlapp describe applications mysqlapp`**|
|**4-3**|Run the following command and notice that the protection state for the application is`none` <br>(which we will fix later):<br>**`kubectl -n mysqlapp get applications`**|
|**4-4**|Review and create an on-demand snapshot in`exercise5Task4-2.yaml`: <br>**`kubectl create -f exercise5Task4-2.yaml`**|
|**4-5**|Check the state of the snapshot custom resource:<br>**`kubectl -n mysqlapp get snapshots`**|
|**4-6**|CHALLENGE STEP: Determine if you created`volumesnapshotcontent` and<br>`volumesnapshot` objects when you created the snapshot.|
|**4-7**|CHALLENGE STEP: Trace the snapshot’s custom resource creation back to ONTAP. Use<br>System Manager or the command line to determine if you created a Snapshot copy.|
|**4-8**|Verify that the bucket now has many more files that represent the Trident Protect snapshot<br>(`exercise5Task4-3.txt`):<br>**`aws --endpoint-url https://192.168.0.74 s3api list-objects-v2 --bucket`**<br>**`tp-src --no-verify-ssl --profile src | more`**|
|**4-9**|Review and create an on-demand backup in`exercise5Task4-4.yaml`: <br>**`kubectl create -f exercise5Task4-4.yaml`**|
|**4-10**|Check the state of the backup custom resource:<br>**`kubectl -n mysqlapp get backups mysqlapp-bkup-1`**<br> <br>HINT: Add**`-w`** to the previous command to watch the backup during creation. When the backup<br>finishes, the state shows as complete. Exit the watch command by entering**Ctrl-C**.|
|**4-11**|CHALLENGE STEP: Determine if you created a snapshot object during the backup’s creation.<br>You might notice in the conditions log that you created, and then deleted, a snapshot during<br>this process.|
|**4-12**|Verify that the bucket now has many more files that represent the Trident Protect Backup<br>(`exercise5Task4-3.txt`):<br>**`aws --endpoint-url https://192.168.0.74 s3api list-objects-v2 --bucket`**<br>**`tp-src --no-verify-ssl --profile src | more `**|



Protecting Trident Worloads M5-E1-P9


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-13**|Verify the protection state reports partial for your application:<br>**`kubectl -n mysqlapp get applications`**<br> <br>NOTE: A partial state means that the application does not have a full backup and so has some<br>vulnerabilities until a backup is completed.|
|**4-14**|Create a schedule for backups and snapshots at 17:30, retaining the last three backups and<br>snapshots:<br>**`kubectl create -f exercise5Task4-5.yaml`**|
|**4-15**|Investigate the schedule:<br>**`kubectl -n mysqlapp get schedules `**|

##### **Task 5: Restore an Application using Trident Protect custom resource**

In this task, restore an application to a new location by using a snapshot and a backup.

|Step|Action|
|---|---|
|**5-1**|Create a namespace as the target location for a new snapshot restore operation:<br>**`kubectl create ns mysqlapp1`**|
|**5-2**|Get the archive path from the snapshot that you created previously (you can find this command<br>in`exercise5Task5-1.txt`):<br>**`kubectl -n mysqlapp get snapshots mysqlapp-snap-1 -o`**<br>**`"jsonpath={.status.appArchivePath}" ; echo` **|
|**5-3**|Replace the`change_me` value in the`appArchivePath` with the value that was returned in<br>the previous command for`exercise5Task5-2.yaml`. Notice that the file adds the resulting<br>namespace as a managed application.|
|**5-4**|Restore the`mysqlapp` from a snapshot to the new namespace and create the new<br>application:<br>**`kubectl create -f exercise5Task5-2.yaml`**|
|**5-5**|Investigate the restore operation:<br>**`kubectl -n mysqlapp1 get snapshotrestore`**|
|**5-6**|After a minute, review the status of the new namespace:<br>**`kubectl -n [target namespace] get all,pvc`**|
|**5-7**|Verify that the new application is available:<br>**`kubectl -n [target namespace] get applications`**|
|**5-8**|Create a namespace as the target location for a new backup restore operation:<br>**`kubectl create ns mysqlapp2`**|



Protecting Trident Worloads M5-E1-P10


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**5-9**|Get the archive path from the snapshot that you created previously (you can find this command<br>in`exercise5Task5-3.txt`):<br>**`kubectl -n mysqlapp get backups mysqlapp-bkup-1 -o`**<br>**`"jsonpath={.status.appArchivePath}" ; echo` **|
|**5-10**|Replace the`change_me` value in the`appArchivePath` with value that was returned in the<br>previous step for`exercise5Task5-4.yaml`. Notice that the file adds the resulting<br>namespace as a managed application.|
|**5-11**|Restore the`mysqlapp` from a backup to the new namespace and create the new application:<br>**`kubectl create -f exercise5Task5-4.yaml` **|
|**5-12**|Investigate the restore operation:<br>**`kubectl -n mysqlapp2 get backuprestore` **|
|**5-13**|After a minute, review the status of the new namespace:<br>**`kubectl -n [target namespace] get all,pvc`**|
|**5-14**|Verify that the new application is available:<br>**`kubectl -n [target namespace] get applications` **|

##### **Task 6: Perform an In-Place Restore using Trident Protect custom resource**

In this task, restore an application in the original location (an in-place restore) by using a snapshot and
a backup.

|Step|Action|
|---|---|
|**6-1**|Get the archive path from the snapshot that you created previously (you can find this command in<br>`exercise5Task6-1.txt`):<br>**`kubectl -n mysqlapp get snapshots mysqlapp-snap-1 -o`**<br>**`"jsonpath={.status.appArchivePath}" ; echo`**|
|**6-2**|Replace the`change_me` value in the`appArchivePath` with value that was returned in the<br>previous command for`exercise5Task6-2.yaml`.|
|**6-3**|Restore the`mysqlapp` from an in-place snapshot:<br>**`kubectl create -f exercise5Task6-2.yaml`**|
|**6-4**|Watch the restore operation until it completes:<br>**`kubectl -n mysqlapp get snapshotinplacerestores -w`**|
|**6-5**|To exit the wait operation, enter**Ctrl-C**.|
|**6-6**|Review the status of the original namespace (review the timestamps to ensure that the<br>application is restored):<br>**`kubectl -n mysqlapp get all,pvc`**|



Protecting Trident Worloads M5-E1-P11


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-7**|Get the archive path from the backup that you created previously (you can find this command in<br>`exercise5Task6-3.txt`):<br>**`kubectl -n trident-protect get backups mysqlapp-bkup-1 -o`**<br>**`"jsonpath={.status.appArchivePath}"`**|
|**6-8**|Replace the`change_me` value in the`appArchivePath` with value that was returned in the<br>previous step for`exercise5Task6-4.yaml`.|
|**6-9**|Restore the`mysqlapp` from an in-place snapshot:<br>**`kubectl create -f exercise5Task6-4.yaml`**|
|**6-10**|Watch the restore operation until it completes:<br>**`kubectl -n mysqlapp get backupinplacerestores -w`**|
|**6-11**|To exit the wait operation, enter**Ctrl-C**.|
|**6-12**|Review the status of the original namespace (review the timestamps to ensure that the<br>application is restored):<br>**`kubectl -n mysqlapp get all,pvc` **|

##### **Task 7: Use tridentctl protect to manage Trident Protect**

In this task, install the `tridentctl protect` tool on your local jumphost. For this task to succeed,
you will need `tridentctl` installed in /usr/local/bin and made executable. NOTE: Many of the
`tridentctl protect` have `--dry-run` appended to run test commands.

|Step|Action|
|---|---|
|**7-1**|Run the shell script from a terminal to install the`tridentctl protect` tool:<br>**`./exercise5Task7-1.sh`**|
|**7-2**|Using`tridentctl` `protect`, check the current applications for the default namespace:<br>**`tridentctl protect get app`**<br>Sample output:<br>`No Applications found in namespace default.`|
|**7-3**|Change the default namespace to`trident-protect` (`exercise5Task7-2.txt`):<br>**`echo 'namespace: mywordpressapp' > ~/.trident-protect/protectctl.yaml`**|
|**7-4**|Using`tridentctl` `protect`, check the current applications for the`trident-protect` <br>namespace:<br>**`tridentctl protect get app`**|
|**7-5**|Experiment with tab complete by entering:<br>**`tridentctl protect [tab]`**<br>NOTE: If the tab complete does not work correctly, open a new terminal and try again.|



Protecting Trident Worloads M5-E1-P12


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**7-6**|Using`tridentctl` `protect`, get the`mysqlapp` application and output the application to<br>yaml:<br>**`tridentctl protect -n mysqlapp get app mysqlapp -o yaml`**|
|**7-7**|Using`tridentctl` `protect`, get the`mysqlapp` application and output the application to<br>json:<br>**`tridentctl protect -n mysqlapp get app mysqlapp -o json`**|
|**7-8**|Using`tridentctl` `protect`, get the objects for Trident Protect:<br>**`tridentctl protect -n mysqlapp get all`**|
|**7-9**|Create a Trident Protect application for the`mywordpressapp` namespace<br>(`exercise5Task7-3.txt`):<br>**`tridentctl protect create app mywordpressapp --namespaces`**<br>**`mywordpressapp`**|
|**7-10**|Notice that you can create an application that spans multiple Kubernetes<br>namespaces. You can also designate certain Kubernetes objects for protection<br>instead of protecting the entire namespace.|
|**7-11**|Using`tridentctl` `protect`, check the applications for the`trident-protect` namespace:<br>**`tridentctl protect get app`**|
|**7-12**|Verify that you configured a AppVault for your ONTAP S3 bucket (`exercise5Task7-3.txt`):<br>**`tridentctl protect -n trident-protect get appvault`**|
|**7-13**|Note: You can also create a AppVault by using the following command (for reference,<br>because you already created the AppVault by using a yaml manifest):<br> <br>**`tridentctl protect create appvault OntapS3 [vault name] -b`**<br>**`[bucketname] -e [endpoint ipaddress] -s [credential secret] --skip-`**<br>**`cert-validation` **|
|**7-14**|Create a snapshot of the WordPress application (`exercise5Task7-3.txt`):<br>**`tridentctl protect create snapshot mywordpressapp-snap-1 --appvault`**<br>**`c1-svmsrc-s3-av --app mywordpressapp`**|
|**7-15**|Verify that you created the WordPress snapshot:<br>**`tridentctl protect get snapshot`**|
|**7-16**|Create a backup of the WordPress application (`exercise5Task7-3.txt`): <br>**`tridentctl protect create backup mywordpressapp-bkup-1 --appvault c1-`**<br>**`svmsrc-s3-av --app mywordpressapp`**|
|**7-17**|Verify that you created the WordPress backup:<br>**`tridentctl protect get backup`**|


Protecting Trident Worloads M5-E1-P13


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**7-18**|Notice that you created a temporary snapshot during the backup process:<br>**`tridentctl protect get snapshot`**<br>Note: The record of the snapshot is persistent in Kubernetes. The snapshot is not destroyed,<br>but the Snapshot copies of the volumes that are associated with the`wordpressapp` <br>application are not persistent.|
|**7-19**|Restore the backup to a new namespace called`mywordpressapp1` <br>(`exercise5Task7-3.txt`):<br>**`tridentctl protect -n mywordpressapp1 create backuprestore mywordpressapp-`**<br>**`bkupr1 --namespace-mapping mywordpressapp:mywordpressapp1 --backup`**<br>**`mywordpressapp/mywordpressapp-bkup-1`**|
|**7-20**|Verify that the WordPress backup restore operation completes successfully:<br>**`tridentctl protect get backuprestore`**<br>Note: The restore takes about 1 minute to complete and, unlike the custom resource method,<br>the namespace is automatically created.|
|**7-21**|CHALLENGE STEP: Using the IDE’s Kubernetes extension or`kubectl`, verify that the new<br>`wordpress` namespace is ready and that the application is running.|
|**7-22**|Restore the backup to the original namespace (`exercise5Task7-3.txt`):<br>**`tridentctl protect create backupinplacerestore mywordpressapp-`**<br>**`backupipr1 --backup mywordpressapp/mywordpressapp-bkup-1`**|
|**7-23**|Verify that the WordPress in-place backup restore operation completes successfully:<br>**`tridentctl protect get backupinplacerestore`**|
|**7-24**|Wait for the restore to complete (`exercise5Task7-3.txt`):<br>**`tridentctl protect wait backupinplacerestore mywordpressapp-backupipr1`**|
|**7-25**|CHALLENGE STEP: Using the IDE’s Kubernetes extension or`kubectl`, verify that the original<br>`wordpress` namespace restarts and that the application is running.|
|**7-26**|Create an hourly schedule to protect the WordPress application (`exercise5Task7-3.txt`):<br>**`tridentctl protect create schedule mywordpressapp-sched1-hourly --app`**<br>**`mywordpressapp --appvault c1-svmsrc-s3-av --granularity Hourly --`**<br>**`minute 15 --backup-retention 3`**<br> <br>Note: if you would like to observe the results, designate the minute value to be in the near<br>future.|
|**7-27**|Verify that you created the schedule:<br>**`tridentctl protect get schedule`**|
|**7-28**|At the minute of your scheduled hourly backup, check the backup:<br>**`tridentctl protect get backup`**|


Protecting Trident Worloads M5-E1-P14


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**7-29**|After the backup completes, check the AppVault content:<br>**`tridentctl protect -n trident-protect get appvaultcontent c1-svmsrc-`**<br>**`s3-av --show-paths --app mywordpressapp`**<br>Note: This command can help you because the command provides archive paths that<br>you need to restore from an AppVault.|
|**7-30**|Provide the path discovered in the previous command and restore the backup to a new<br>namespace called`mywordpressapp2`: <br>**`tridentctl protect -n mywordpressapp2 create backuprestore`**<br>**`mywordpressapp-bkupr2 --namespace-mapping`**<br>**`mywordpressapp:mywordpressapp2 --appvault c1-svmsrc-s3-av --path [path`**<br>**`from previous command]`**|
|**7-31**|Verify that the WordPress backup restore operation completes successfully by using the`wait` <br>command (`exercise5Task7-3.txt`):<br>**`tridentctl protect wait backuprestore mywordpressapp-bkupr2`**|
|**7-32**|CHALLENGE STEP: Using the IDE’s Kubernetes extension or`kubectl`, verify that you<br>created the new`wordpress` namespace and that the application is running.|


**End of exercise**


Protecting Trident Worloads M5-E1-P15


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 6: Business Continuity**

##### **Exercise 1: Protecting Trident Workloads Across Clusters**

In this exercise, you install

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Setup the second Kubernetes clusters

- Configure Kubernetes to use the destination SVM

- Restore an application to a new cluster using Trident Protect

- Mirror an application across two clusters

- Fail over an application

- Fail back an application

##### **Exercise Equipment**


In this exercise, you use the following systems.

|System|Host<br>Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|Linux Mint 20|jumphost|192.168.0.5|user (case sensitive)|Netapp1!|
|Kubernetes Control Plane 1|kubmas1-1|192.168.0.61|root (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor1-1|192.168.0.62|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor1-2|192.168.0.63|root (case sensitive)|Netapp1!|
|Kubernetes Worker3|kubwor1-3|192.168.0.64|root (case sensitive)|Netapp1!|
|Kubernetes Control Plane 2|kubmas2-1|192.168.0.96|root (case sensitive)|Netapp1!|
|Kubernetes Worker 1|kubwor2-1|192.168.0.97|root (case sensitive)|Netapp1!|
|Kubernetes Worker 2|kubwor2-2|192.168.0.98|root (case sensitive)|Netapp1!|
|ONTAP cluster management|cluster1|192.168.0.101|admin (case sensitive)|Netapp1!|
|ONTAP cluster management|cluster2|192.168.0.102|admin (case sensitive)|Netapp1!|


##### **Prerequisites**


Before starting this exercise, you should take the following actions:


- Set up your integrated development environment (IDE)

- Download the courseware GIT repository

- Configure your IDE to access your Kubernetes clusters

- Install Trident in your source Kubernetes cluster

- Ensure that iSCSI, NVMe, and NFS are properly configured on your worker nodes in the source
Kubernetes cluster

- Add Container Storage Interface (CSI) snapshot support and a VolumeSnapshotClass

- Create svmsrc and svmdst

- Install Trident Protect on both source and destination cluster

- Create the `mysqlapp` and `mywordpressapp` applications by using Helm


Protecting Trident Workloads Across Clusters M6-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 1: Set up the second Kubernetes cluster**

In this task, install Trident, CSI volume snapshot support, and MetalLB.

|Step|Action|
|---|---|
|**1-1**|Set the current context to the destination cluster (`exercise6Task1-1.txt`):<br> **`kubectl config use-context destination-admin@destination`**<br>Note: You can also set the switch context by using the IDE Kubernetes extension.|
|**1-2**|Setup Trident’s custom resource definitions (CRDs) in the destination cluster. If you need<br>assistance, please check out Exercise 2.<br>For a solution, please see`Solutions/exercise6Task1-2.yaml`.|
|**1-3**|Install Trident’s operator in the destination cluster. If you need assistance, please check out<br>Exercise 2.<br>For a solution, please see`Solutions/exercise6Task1-3.yaml`.|
|**1-4**|Create a Trident Orchestrator custom resource (CR) in the destination cluster. If you need<br>assistance, please check out Exercise 2.<br>For a solution, please see`Solutions/exercise6Task1-4.yaml`.|
|**1-5**|Install Kubernetes CSI snapshot support in the destination cluster. If you need assistance,<br>please check out Exercise 4.<br>For a solution, please see`Solutions/exercise6Task1-5.yaml`.|
|**1-6**|Create a default volume snapshot class in the destination cluster. If you need assistance,<br>please check out Exercise 2.<br>For a solution, please see`Solutions/exercise6Task1-6.yaml`.|
|**1-7**|Install the MetalLB load balancer. If you need assistance, please check out Exercise 5.<br>For a solution, please see`Solutions/exercise6Task1-7.yaml`.|
|**1-8**|Wait a minute for MetalLB to finish provisioning, and then apply the configuration with the IP<br>range of 192.168.0.245-249. If you need assistance, please check out Exercise 5.<br>For a solution, please see`Solutions/exercise6Task1-8.yaml`.|
|**1-9**|Remember you installed Trident Protect in the second cluster already.  Next, make sure that<br>the second Kubernetes has been configured to use storage protocols by executing:<br>**`./exercise6Task1-9.sh`**|



Protecting Trident Workloads Across Clusters M6-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 2: Configure Kubernetes to use the destination SVM**

In this task, create Trident back ends and storage classes to support the `svmdst` SVM. NOTE: This
svm was created in the exercise for Module 5 using the Gateway operator. Please see
`exercise5Task2-5.yaml` for details.

|Step|Action|
|---|---|
|**2-1**|Create a back-end secret and TridentBackend configurations for cluster2`svmdst` (see the<br>`exercise6Task2-1.yaml` file).<br>• <br>For`c2-svmdst-backend-secret`: <br>`o` Username:**vsadmin**<br>`o` Password:**Netapp1! **<br>• <br>For`c2-svmdst-nfs-custom-tbc`: <br>`o` Management LIF:**192.168.0.80**<br>`o` Data LIF:**192.168.0.81**<br>`o` SVM:**svmdst**<br>• <br>For`nfs-custom-sc`:<br>`o` storagePools: "c2-svmdst-nfs-custom-tbe:.*<br> <br>NOTE: The name of the storage is the same as the storage class used in Kubernetes cluster 1.<br>This required to create an application mirror.|
|**2-2**|Verify that you successfully created the back-end configuration:<br>**`kubectl -n trident get tbc -o wide`**|
|**2-3**|Verify that you successfully created the StorageClass configuration:<br>**`kubectl get sc`**|
|**2-4**|Use the`tridentctl` tool to identify the storage classes that map to the correct back ends<br>(you can copy this command from the`exercise6Task2`-2`.txt` file):<br>**`tridentctl get backend -n trident -o json | jq '[.items[] | {backend: .name,`**<br>**`storageClasses: [.storage[].storageClasses]|unique}]'`**|


##### **Task 3: Restore an application to a new cluster using Trident Protect**


In this task, restore an application by using a backup. Note: The files in this exercise are the same files
that you used in the Module 5 exercise.

|Step|Action|
|---|---|
|**3-1**|Review and create an AppVault that accesses the`tp-src` bucket in the ONTAP cluster1<br>`svmsrc` in the destination Kubernetes cluster:<br>**`kubectl create -f exercise6Task3-1.yaml`**<br>NOTE: The secret in the Kubernetes source cluster containing the access key and secret key<br>for the S3 user account was initially created by the Gateway operator when configuring the S3<br>server. Then the secret was copied to the destination Kubernetes cluster using<br>`exercise5Task2-6.sh`.|



Protecting Trident Workloads Across Clusters M6-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-2**|Verify that the state of the new AppVault is available:<br>**`kubectl -n trident-protect get appvault`**|
|**3-3**|Review and create an AppVault that accesses the`tp-dst` bucket in the ONTAP cluster2<br>`svmdst` in the destination Kubernetes cluster:<br>**`kubectl create -f exercise6Task3-2.yaml`**<br>NOTE: The secret in the Kubernetes destination cluster containing the access key and secret<br>key for the S3 user account was initially created by the Gateway operator when configuring the<br>S3 server. Then the secret was copied to the source Kubernetes cluster using exercise5Task2-<br>7.sh.|
|**3-4**|Verify that the state of the new AppVault is available:<br>**`kubectl -n trident-protect get appvault`**|
|**3-5**|Create a stub source namespace:<br>**`kubectl create ns mysqlapp`**|
|**3-6**|Create a destination namespace:<br>**`kubectl create ns mysqlapp2`**|
|**3-7**|Rerun`exercise5Task5-4.yaml` in the destination cluster:<br>**`kubectl create -f exercise5Task5-4.yaml`**|
|**3-8**|Investigate the restore operation:<br>**`kubectl -n mysqlapp get backuprestores -w`**|
|**3-9**|After a minute, review the status of the new namespace:<br>**`kubectl -n [target namespace] get all,pvc`**|
|**3-10**|Verify that the new application is available:<br>**`kubectl -n [target namespace] get applications`**|

##### **Task 4: Mirror an Application Across Two Clusters**

In this task, configure an AppMirror relationship for the WordPress application. This task requires that
the ONTAP cluster and SVM peering to support the SnapMirror relationship for the AppMirror feature.
For more information about peering, see the _ONTAP Data Protection Administration_ course.

|Step|Action|
|---|---|
|**4-1**|Verify that you have in both Kubernetes clusters a default storage class with same<br>name called`nfs-custom-sc` associated with an nfs custom named Trident back<br>end. We need a common storage class name between the clusters to create an<br>AppMirror relationship.|
|**4-2**<br>|Ensure you are in the source cluster (`exercise6Task4-1.txt`):<br>**`kubectl config use-context source-admin@source` **<br>|



Protecting Trident Workloads Across Clusters M6-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-3**|Set up a schedule for the WordPress application that takes Snapshot copies every 5 minutes<br>and retains five total snapshots:<br> **`kubectl create -f exercise6Task4-2.yaml`**|
|**4-4**|Get the user ID (UID) for the WordPress application (`exercise6Task4-3.txt`):<br> **`kubectl -n mywordpressapp get applications mywordpressapp`**<br>**` -o "jsonpath={.metadata.uid}" ; echo`**<br> <br>UID:_____________________________________________|
|**4-5**|Verify that the KubeConfig context is set to the destination Kubernetes cluster<br>(`exercise6Task4-4.txt`):<br> **`kubectl config use-context destination-admin@destination`**<br>NOTE: You can also set the switch context by using the IDE Kubernetes extension.|
|**4-6**|Verify that the`trident-protect` namespace has the source and destination S3 AppVault<br>buckets and that each AppVault is in the “Available” state. You created these back in Task 3 of<br>this exercise.<br>**`kubectl -n trident-protect get appvaults`**<br>**`tridentctl protect -n trident-protect get appvault -A`**|
|**4-7**|Create a destination namespace for the WordPress application in the destination cluster:<br>**`kubectl create -f exercise6Task4-5.yaml`**|
|**4-8**|Create a destination application for the WordPress application in the destination cluster:<br>**`kubectl create -f exercise6Task4-6.yaml`**|
|**4-9**|Verify that the destination application is in the “Ready” state:<br>**`tridentctl protect -n mywordpressapp-dst get app`**|
|**4-10**<br>|Edit the`exercise6Task4-7.yaml` to change the`change_me` values for the fields:<br>• <br>`sourceApplicationUID`: to the value that you retrieved in Step 4-5 of this task<br>• <br>`desiredState`: Established<br>• <br>`destinationAppVaultRef`: c2-svmdst-s3-av<br>• <br>`sourceAppVaultRef`: c1-svmsrc-s3-av<br>• <br>`storageClassName`: nfs-custom-sc<br>• <br>namespaceMapping.destination: mywordpressapp-dst<br>• <br>namespaceMapping.source: mywordpressapp<br>• <br>sourceApplicationName: mywordpressapp<br>|


Protecting Trident Workloads Across Clusters M6-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**4-11**|Watch the progress of the AppMirror relationship (see`exercise6Task4-8.txt`) and then,<br>after the state is “established,” exit the watch command by entering**Ctrl-C**. <br>**`kubectl -n mywordpressapp-dst get amr mywordpressapp-dst-amr -w`**<br>**`tridentctl protect -n mywordpressapp-dst get amr`**<br>NOTE: One of the scheduled snapshot must exist. They occur every 5 minutes. If you get to<br>the is point before the first snapshot occurs, just wait for the first Snapshot copy to be created.<br>The operation takes about 4 minutes to move from “establishing” to “established.”|
|**4-12**|Review the resulting namespace and notice that only the persistent volume claims (PVCs) are<br>created in the destination cluster:<br>**`kubectl -n mywordpressapp-dst get all,pvc`**|

##### **Task 5: Fail Over an Application**

In this task, perform a failover operation for the WordPress application.

|Step|Action|
|---|---|
|**5-1**|After you establish an AppMirror relationship, change the desired state to “promoted” by using<br>the following command (see`exercise6Task5-1.txt`):<br>**`kubectl patch amr -n mywordpressapp-dst mywordpressapp-dst-amr --`**<br>**`type='json' -p '[{"op": "replace", "path": "/spec/desiredState",`**<br>**`"value":"Promoted"}]'`**|
|**5-2**|Watch the progress of the AppMirror relationship (see`exercise6Task5-2.txt`) and then,<br>after the state is “promoted,” exit the watch command by entering**Ctrl-C**. <br>**`kubectl -n mywordpressapp-dst get amr mywordpressapp-dst-amr -w`**<br>**`tridentctl protect -n mywordpressapp-dst get amr`**|
|**5-3**|Using the IDE Kubernetes extension or`kubectl`, examine the destination namespace of the<br>WordPress application:<br> **`kubectl -n mywordpressapp-dst get all,pvc`**<br>**NOTE:**This operation takes about 3 minutes before the pods are ready.|
|**5-4**|CHALLENGE STEP: Log in to the WordPress application at the destination site.|
|**5-5**|What is the state of the WordPress application and its namespace objects and PVCs in the<br>source cluster?|


##### **Task 6: Fail Back an Application**


In this task, perform a failback operation for the WordPress application.

|Step|Action|
|---|---|
|**6-1**|Verify that the KubeConfig context is set to the destination cluster:<br> **`kubectl config use-context destination-admin@destination`**<br>Note: You can also set the switch context by using the IDE Kubernetes extension.|



Protecting Trident Workloads Across Clusters M6-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**6-2**|After you establish an AppMirror relationship, change the desired state to “promoted” by using<br>the following command (see`exercise6Task6-1.txt`):<br>**`kubectl patch amr -n mywordpressapp-dst mywordpressapp-dst-amr --`**<br>**`type='json' -p '[{"op": "replace", "path": "/spec/desiredState",`**<br>**`"value":"Established"}]'`**|
|**6-3**|Watch the progress of the AppMirror relationship (see`exercise6Task6-2.txt`) and then,<br>after the state is “established,” exit the watch command by entering**Ctrl-C**.<br>**`kubectl -n mywordpressapp-dst get amr mywordpressapp-dst-amr -w`**<br>**`tridentctl protect -n mywordpressapp-dst get amr`**<br>Note: This operation takes about 3 minutes for the state to register as “established.”|
|**6-4**|Using the IDE Kubernetes extension or`kubectl`, check out the destination namespace of the<br>WordPress application:<br> **`kubectl -n mywordpressapp-dst get all,pvc`**|
|**6-5**|CHALLENGE STEP: Log in to the WordPress application at the source site.|
|**6-6**|What is the state of the WordPress application and its namespace objects and PVCs in the<br>destination cluster?|
|**6-7**|CHALLENGE STEP: Perform a reverse resynchronization, which reverses the relationship.<br>The old source becomes the new destination and the old destination becomes the new source.|
|**6-8**|CHALLENGE STEP: Perform a reverse replication direction, which reverses the relationship.<br>The old source becomes the new destination and the old destination becomes the new source.|
|**6-9**|CHALLENGE STEP: If you have completed the challenge steps of 6-7 and 6-8, then you have<br>successfully completed a failback recovery.|


**End of exercise**


Protecting Trident Workloads Across Clusters M6-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 7: Trident Monitoring**

##### **Exercise 1: Monitoring NetAppTrident**

In this exercise, you install Prometheus and Grafana in your Kubernetes cluster and configure a
Grafana dashboard for the Kubernetes content. You create a sample app, collect telemetry data from
the sample app, and configure NetAppTrident as a Prometheus target.

##### **Objectives**


This exercise focuses on enabling you to do the following:


- Host Prometheus and its supporting applications in Kubernetes

- Configure a sample application as a Prometheus target

- Configure Trident as a Prometheus target

##### **Exercise Equipment**


In this exercise, you use the following system.

|System|Host Name|IP Addresses|User Name|Password|
|---|---|---|---|---|
|~~Linux Mint 20~~|~~jumphost~~|~~192.168.0.5~~|~~user (case sensitive)~~|~~Netapp1!~~|


##### **Task 1: Host Prometheus and Its Supporting Applications in Kubernetes**


In this task, you configure Prometheus and its supporting applications to run in Kubernetes. For more
[information about this procedure, see https://github.com/prometheus-operator/kube-prometheus.](https://github.com/prometheus-operator/kube-prometheus)

|Step|Action|
|---|---|
|**1-1 **|In a terminal window in your integrated development environment (IDE), change the directory<br>to the`Extras/monitoring/kube-prometheus-<`_`version`_`>` folder in the course content<br>repository.|
|**1-2 **|Review the “1-setup” subfolder and, from the terminal, apply all the custom resource definitions<br>(CRDs) to your Kubernetes cluster:<br>**`kubectl create -f 1-setup/` **|
|**1-3 **|The output of step 1-2 should show that you applied seven CRDs and created the<br>`monitoring` namespace. These definition files come from<br>https://github.com/prometheus-operator/kube-prometheus/tree/main/manifests/setup.|
|**1-4 **|Review the “2-manifests" subfolder and, from the terminal, apply all the CRDs to your<br>Kubernetes cluster:<br>**`kubectl create -f 2-manifests/` **|
|**1-5 **|A long output should show the many objects that you created. These definition files<br>come fromhttps://github.com/prometheus-operator/kube-<br>prometheus/tree/main/manifests.|
|**1-6 **|Watch the pod creation:<br>**`kubectl -n monitoring get pods --watch`**|



Montioring NetApp Trident M7-E1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-7 **|After all the pods are ready, use**Ctrl-C** to break the`watch` command.|
|**1-8 **|You created the following pods:<br>• The Prometheus Operator (one pod) manages all the other Prometheus pods<br>and deploys two Prometheus instances.<br>• <br>Prometheus Kubernetes (K8s) (two pods, tuned to one pod for this exercise) aggregates<br>metrics.<br>• <br>Alertmanager (three pods, tuned to one pod for this exercise) communicates Prometheus<br>data to external services.<br>• <br>Kube State Metrics (one pod) scrapes telemetry data from your Kubernetes control plane<br>services.<br>• <br>Node Exporter (four pods, one for each node) scrapes telemetry data from your<br>Kubernetes nodes.<br>• <br>Grafana (one pod) provides a front-end UI for the Prometheus data.<br>• <br>Blackbox Exporter (one pod) enables blackbox probing of endpoints over HTTP, HTTPS,<br>DNS, TCP, and Internet Control Message Protocol (ICMP).<br>• <br>Prometheus Adapter (two pods, tuned to one) contains an implementation of the<br>Kubernetes resource metrics, custom metrics, and external metrics APIs to use with the<br>Horizontal Pod Autoscaler.|
|**1-9 **|Start port-forwarding for the`prometheus-k8s` service in a new terminal window:<br>**`kubectl -n monitoring port-forward svc/prometheus-k8s 9090`**|
|**1-10**|Open a web browser tab tohttp://localhost:9090.|
|**1-11**|Explore the default Prometheus interface.|
|**1-12**|Click the**Alerts** menu to see how all the preconfigured alerts are created. Green means that<br>the condition is normal and red means that the condition is overcommitted.|
|**1-13**|Prometheus keeps all its data in memory. You can configure Prometheus for remote-<br>write to persist the data to an external service for management and archiving.|
|**1-14**|List all the available service monitors:<br>**`kubectl -n monitoring get servicemonitors`**|
|**1-15**|In the Prometheus UI, go to**Status > Targets** and make sure that the menu lists the service<br>monitors that are already configured for you.|
|**1-16**|To explore how these service monitors work, describe them:<br>**`kubectl -n monitoring describe servicemonitors kube-apiserver`**|


Montioring NetApp Trident M7-E1-P2


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**1-17**|Notice that a section at the end of the`describe` output has a selector and matches the labels<br>`component:apiserver` and`provider:kubernetes`. <br>If you investigate the API server service that runs in the default namespace called<br>`kubernetes`, notice that the service’s labels are`component:apiserver` and<br>`provider:Kubernetes`. Using this label relationship, the service monitor retrieves data from<br>the`kubernetes` service that communicates with the control plane’s API service.|
|**1-18**|Start port-forwarding for the Grafana service in a new terminal window:<br>**`kubectl -n monitoring port-forward svc/grafana 3000`**|
|**1-19**|Open a web browser tab tohttp://localhost:3000.|
|**1-20**|On the Grafana login page, provide the following credentials:<br>• <br>Login:**admin** <br>• <br>Password:**admin**<br>• <br>When prompted to change the password, select**Skip**. <br>You should be authenticated with Grafana.|
|**1-21**|From the left menu, select the**Home** menu<br> and then select**Connections** and**Data**<br>**sources**.|
|**1-22**|Under “Data sources,” find a Prometheus entry.|
|**1-23**|Select this Prometheus entry as the**Prometheus data source**.|
|**1-24**|At the bottom of the Prometheus data source, click**Test**. <br>The data source should report that it works correctly.|
|**1-25**|On the Grafana page, click the**+** sign in the upper-right corner and then click**Import**<br>**dashboard**.|
|**1-26**|In your course materials, open the`exercise7Task1-1.json` file and copy all the contents<br>by using**Ctrl-A** and then**Ctrl-C**.|
|**1-27**|On the Grafana import page, paste the contents of the`exercise7Task1-1.json` file into the<br>“Import JSON” text box.|
|**1-28**|At the bottom of the page, click**Load**.|
|**1-29**|On the Options page, select the**Prometheus data source** from the list and keep all other<br>options as the defaults.|
|**1-30**|Click**Import** to create the dashboard.|
|**1-31**|Review the dashboard that you created with the Prometheus data. Find additional dashboards<br>athttps://grafana.com/grafana/dashboards/.|


Montioring NetApp Trident M7-E1-P3


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


##### **Task 2: Configure a Sample Application as a Prometheus Target**

In this task, you configure a sample deployment that runs three replicas of a pod that produces
telemetry data. Then, you create a service monitor to register these replicas as a Prometheus target.
Finally, you configure a Grafana dashboard to view the metrics from the sample application.

|Step|Action|
|---|---|
|**2-1 **|Review and run the`exercise7Task2-1.yaml` file, which creates a deployment and service<br>of a sample app:<br>**`kubectl create -f exercise7Task2-1.yaml`**|
|**2-2 **|Review and run the`exercise7Task2-2.yaml` file, which creates a service monitor for the<br>sample app:<br>**`kubectl create -f exercise7Task2-2.yaml`**|
|**2-3 **|On the Prometheus Status Targets page, you should see the target<br>`serviceMonitor/monitoring/example-app`.|
|**2-4 **|On the Grafana page, click the**+** sign in the left menu bar and then click**Import Dashboard**.|
|**2-5 **|In your course materials, open the`exercise7Task2-3.json` file and copy all the contents<br>by using**Ctrl-A** and then**Ctrl-C**.|
|**2-6 **|On the Grafana import page, paste the contents of the`exercise7Task2-3.json` file into the<br>“Import JSON” text box.|
|**2-7 **|At the bottom of the page, click**Load**.|
|**2-8 **|On the Options page, select the**Prometheus data source** from the list and keep all other<br>options as the defaults.|
|**2-9 **|Click**Import** to create the dashboard.|
|**2-10**|Review the dashboard that you created with the Kubernetes deployment data.|


##### **Task 3: Configure Trident as a Prometheus Target**


In this task, you use Prometheus to monitor the `trident` namespace. You investigate how the Trident
service is configured for an endpoint that exposes the metric port that is configured in the Trident pod.
You verify that telemetry data comes from this endpoint. Then you create a service monitor to enable
Trident to become a Prometheus target. Finally, you configure the Grafana dashboard to view the
Trident telemetry.

|Step|Action|
|---|---|
|**3-1 **|Check if the`prometheus-k8s` service account can monitor the`trident` namespace:<br>**`kubectl -n trident auth can-i get pods`**<br>**`            --as=system:serviceaccount:monitoring:prometheus-k8s` **|
|**3-2 **|Answer the following question:<br>What is the response to the command in step 3-1?<br>The response should be`yes`, or you do not get telemetry data from Trident. Unfortunately, the<br>answer in this case is`no`.|



Montioring NetApp Trident M7-E1-P4


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-3 **|Review and run the`exercise7Task3-1.yaml` file, which creates a role and role binding to<br>enable Prometheus to monitor the trident namespace:<br>**`kubectl create -f exercise7Task3-1.yaml` **|
|**3-4 **|Recheck to see if the`prometheus-k8s` service account can monitor the`trident` <br>namespace:<br>**`kubectl -n trident auth can-i get pods`**<br>**`            --as=system:serviceaccount:monitoring:prometheus-k8s` **|
|**3-5 **|Describe the`trident` service:<br>**`kubectl -n trident describe svc trident-csi` **|
|**3-6 **|Notice which port is exposed for metrics: 9220/TCP.<br>Important:_Always_ reference this port by its name, not by the port number for Prometheus. The<br>port’s name is`metrics`.|
|**3-7 **|In your IDE terminal, split the terminal (by using the menus or** Ctrl-Shift-5**) so that you have<br>two terminals, then label the terminals TERMINAL 1 and TERMINAL 2).|
|**3-8 **|In TERMINAL 1, start a port-forwarding process from the metric port (and identify the port that<br>is being forwarded):<br>**`kubectl -n trident port-forward service/trident-csi :metrics`**<br>Sample output:<br>`kubectl port-forward service/trident-csi -n trident :metrics`<br>`Forwarding from 127.0.0.1:`**`65512`**` -> 8001`<br>`Forwarding from [::1]:65512 -> 8001`|
|**3-9 **|In TERMINAL 2, issue the following command:<br>**`curl -s localhost:[`****_`port forwarded from step 3-8`_****`] | grep trident_backend_count` **<br>The following command is equivilant to using a Microsoft Windows PowerShell:<br>**`Invoke-RestMethod http://127.0.0.1:[`****_`port forwarded from step 3-8`_****`] | findstr`**<br>**`‘trident_backend_count’`**|
|**3-10**|In TERMINAL 1, use**Ctrl-C** to exit the port-forwarding process.|
|**3-11**|Close TERMINAL 2.|
|**3-12**|Review and run the`exercise7Task3-2.yaml` file, which creates a service monitor for<br>Trident:<br>**`kubectl create -f exercise7Task3-2.yaml`**|


Montioring NetApp Trident M7-E1-P5


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-13**|The service monitor does the following things:<br>• The service monitor looks for metrics that the`trident-csi` service retrieves.<br>(Look for the`app` label that you match. This`app` label is present on the`trident-`<br>`csi` service that runs in the`trident` namespace, as specified in<br>the`namespaceSelector`).<br>• <br>The`endpoint` for these metrics is defined as the metrics port that the`trident-`<br>`csi` service exposes.|
|**3-14**|From the Prometheus UI webpage, navigate to**Status > Target** and verify that the Trident<br>service monitor appears in the list of targets. NOTE: This list can take up to 5 minutes to<br>appear.|
|**3-15**|From the Prometheus UI webpage, navigate to the**Graph** section. Following are examples of<br>some of the possible expressions.|
|**3-16**|In the panel, add the following information to the Expression line:<br>**`trident_backend_count`**<br>(total number of volumes per back end)|
|**3-17**|Click**Execute**.|
|**3-18**|Review the data in the table format.|
|**3-19**|Click**Add Panel**to add a second panel.|
|**3-20**|In the second panel, add the following information to the Expression line:<br>**`kubelet_volume_stats_used_bytes{namespace='trident'}/(1024*1024*1024)`**<br>(used bytes per PVC for the`trident` namespace)|
|**3-21**|Review the data in the table format.|
|**3-22**|Click**Add Panel**to add a third panel.|
|**3-23**|In the third panel, add the following information to the Expression line:<br>**`trident_volume_count * on (backend_uuid)`**<br>**`group_left (backend_name, backend_type) trident_backend_info`**<br>**`or on (backend_uuid) trident_volume_count`**<br>(the number of volumes per back end)|
|**3-24**|Review the data in the table format.|
|**3-25**|Click**Add Panel**to add a fourth panel.|
|**3-26**|In the fourth panel, add the following information to the Expression line:<br>**`(sum(trident_volume_allocated_bytes) by (backend_uuid)) / (1024*1024*1024)`**<br>**`* on (backend_uuid) group_left(backend_name) trident_backend_info`**<br>(the number of volumes per back end)|


Montioring NetApp Trident M7-E1-P6


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


|Step|Action|
|---|---|
|**3-27**|Review the data in the table or graphic format. You might find this review more interesting if<br>you complete this exercise before completing the Module 4 exercise.|
|**3-28**|Click**Add Panel**to add a fifth panel.|
|**3-29**|In the fifth panel, add the following information to the Expression line:<br>**`rate(trident_ontap_operation_duration_in_milliseconds_by_svm_sum{op="ems-`**<br>**`autosupport-log"}[5m])`**<br>(operations per SVM)|
|**3-30**|Review the data in the table or graphic format.|
|**3-31**|On the Grafana page, click the**+** sign in the left menu bar, and then click**Import**.|
|**3-32**|In your course materials, open the`exercise7Task3-3.json` file and copy all the contents<br>by using**Ctrl-A** and then**Ctrl-C**.|
|**3-33**|Return to the Grafana import page and paste the contents of the`exercise7Task3-3.json` <br>file into the “Import JSON” text box.|
|**3-34**|At the bottom of the page, click**Load**.|
|**3-35**|Click**Import** to create the dashboard.|
|**3-36**|Review the dashboard that you created using the Trident data.|


**End of exercise**


Montioring NetApp Trident M7-E1-P7


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Module 8: Trident Provisioning Security**

There is no exercise for this module.


Trident Provisioning Security M8-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Appendix 1: Kubernetes-Related Certifications**

There is no exercise for this appendix.


Kubernetes-Related Certifications A1-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Appendix 2: An Introduction to Operators**

There is no exercise for this appendix.


An Introduction to Operators A2-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


### **Appendix 3: GitsOps Introduction**

There is no exercise for this appendix.


GitsOps Introduction A3-P1


© 2025 NetApp, Inc. This material is intended only for training. Reproduction is not authorized.


NetApp Learning Services - Do Not Distribute


