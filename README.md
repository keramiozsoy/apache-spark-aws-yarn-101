# apache-spark-cloud-101




1 - Create Aws Acount


2 - AWS Cloud9
- Search on the bar 
- Create Environment
- Name : delabdemo
- Environment Type  : new e2c instance
- Instance Type  : t3.medium ( 4 GiB RAM  + 2 vCPU )
- Platform : Ubuntu Server 18.04 LTS
- Timeout  : 30 minutes
- Press Create and wait to compleate process.
- Click and open Cloud9 IDE.


3 - EC2 Instance
- Search on the bar
- Click on running EC2 instance
- You will see the ec2 instance. We have just created previous step with AWS Cloud9
- Find, Copy -> Public IPv4 DNS -> and paste to the browser.
- It will not work.



4 - Open terminal on AWS Cloud9
- whenever you provisioned an instance on aws, you will be getting The Apache HTTP Server up and running.


```SHELL
$ sudo systemctl status apache2
● apache2.service - The Apache HTTP Server
   Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
  Drop-In: /lib/systemd/system/apache2.service.d
           └─apache2-systemd.conf
   Active: active (running) since Wed 2023-07-26 16:21:52 UTC; 17min ago
  Process: 872 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
 Main PID: 996 (apache2)
    Tasks: 6 (limit: 4612)
   CGroup: /system.slice/apache2.service
           ├─ 996 /usr/sbin/apache2 -k start
           ├─1006 /usr/sbin/apache2 -k start
           ├─1007 /usr/sbin/apache2 -k start
           ├─1008 /usr/sbin/apache2 -k start
           ├─1009 /usr/sbin/apache2 -k start
           └─1010 /usr/sbin/apache2 -k start

$ telnet localhost 80
Trying 127.0.0.1...
Connected to localhost.
```

- It will not work. The reason is the por is not opened as part of the security group.
- Search on the bar
- Click on running EC2 instance
- Click Security Tab -> Click Security Groups
- Security Group is firewall within the system.
- Find Inbound Rules
- Edit Inbound Rules
- Add Rule
- Type : HTTP
- Source: My IP ( it means, It will get your IP address, and it will connect only you.)
- Save Rule.
- Click on running EC2 instance
- Find, Copy -> Public IPv4 DNS -> and paste to the browser.
- it works :) ( you will see Apache2 Default Page)

- We are able to access the page until the instance shutown. Because the IP will change.
- If we don't want to face this issue, we can create Elastic IP.

4 - EC2 Instance
- Search on the bar
- Click on running EC2 instance
- Click Instance State and Stop Instance on top of page.
- The instance will start automatically, because of Cloud9 is already active.
- Lets check the ip and public IPv4 DNS are complately different.
- It is hard to use Public IPv4 DNS as each time different address.

5 - EC2 Instance
- Search on the bar
- Elastic IP Address
- Allocate.
- Edit Name : delabdemo
- Click Actions > Associate Elastic IP Address.
- Click the running instance.
- Associate.
- Now, Public IPv4 DNS will not be change.
- Click the running instance. Try to reboot instance. You will use same Public IPv4 DNS

6 - AWS Cloud9
- Search on the bar 
- open terminal

```SHELL
$ df -h
Filesystem       Size  Used Avail Use% Mounted on
udev             1.9G     0  1.9G   0% /dev
tmpfs            388M  824K  387M   1% /run
/dev/nvme0n1p1   9.6G  5.6G  4.0G  59% /
tmpfs            1.9G     0  1.9G   0% /dev/shm
tmpfs            5.0M     0  5.0M   0% /run/lock
tmpfs            1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/loop0        25M   25M     0 100% /snap/amazon-ssm-agent/6563
/dev/loop2        56M   56M     0 100% /snap/core18/2785
/dev/loop1        54M   54M     0 100% /snap/snapd/19457
/dev/nvme0n1p15  105M  5.3M  100M   5% /boot/efi
tmpfs            388M     0  388M   0% /run/user/1000
```

- Look at / (root) 
- we would like to increase storage, we are able to use Amazon EBS storage.
- Go to EC2 Instance
- Click running instance
- Click section Storage
- Click Block Devices
- Click Volume (10 GB)
- Edit name exising volume as
- Click Actions -> Modify Volume
- Increase size from 10 GiB to 32 Gib.
- Modify.
- Refresh Page and see 32 GiB.
- The volume is increased but Cloud9 will not affected yet.
- Go to EC2 Instance
- Click running instance
- Click Instance Stat -> Reboot Instance
- Look at / (root)
- :)
  
```SHELL
$ df -h
Filesystem       Size  Used Avail Use% Mounted on
udev             1.9G     0  1.9G   0% /dev
tmpfs            388M  824K  387M   1% /run
/dev/nvme0n1p1    31G  5.6G   26G  19% /
tmpfs            1.9G     0  1.9G   0% /dev/shm
tmpfs            5.0M     0  5.0M   0% /run/lock
tmpfs            1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/loop0        25M   25M     0 100% /snap/amazon-ssm-agent/6563
/dev/loop2        54M   54M     0 100% /snap/snapd/19457
/dev/loop1        56M   56M     0 100% /snap/core18/2785
/dev/nvme0n1p15  105M  5.3M  100M   5% /boot/efi
tmpfs            388M     0  388M   0% /run/user/1000
```

7 - Setup Jupyter Lab on Cloud9
- Cloud 9
- Search on the bar
- open terminal

```SHELL
python3
```
run to exit below command
```SHELL
exit()
```

```SHELL
$ mkdir delab
$ cd delab
```


```SHELL
$ python3 -m venv delab-venv
$ find delab-venv/


$ find delab-venv/
delab-venv/
delab-venv/bin
delab-venv/bin/pip3
delab-venv/bin/pip
delab-venv/bin/easy_install
delab-venv/bin/pip3.6
delab-venv/bin/activate
...

```

```SHELL
$ ls -ltr delab-venv/bin
total 32
lrwxrwxrwx 1 ubuntu ubuntu   16 Jul 26 17:49 python3 -> /usr/bin/python3
lrwxrwxrwx 1 ubuntu ubuntu    7 Jul 26 17:49 python -> python3
-rwxrwxr-x 1 ubuntu ubuntu  271 Jul 26 17:49 easy_install-3.6
-rwxrwxr-x 1 ubuntu ubuntu  271 Jul 26 17:49 easy_install
-rwxrwxr-x 1 ubuntu ubuntu  243 Jul 26 17:49 pip3.6
-rwxrwxr-x 1 ubuntu ubuntu  243 Jul 26 17:49 pip3
-rwxrwxr-x 1 ubuntu ubuntu  243 Jul 26 17:49 pip
-rw-r--r-- 1 ubuntu ubuntu 2449 Jul 26 17:49 activate.fish
-rw-r--r-- 1 ubuntu ubuntu 1285 Jul 26 17:49 activate.csh
-rw-r--r-- 1 ubuntu ubuntu 2229 Jul 26 17:49 activate
```

Let's activate python env.

```SHELL
$ source delab-venv/bin/activate
```
Let's install jupyterlab

```SHELL
$ python -m pip install --upgrade pip
$ pip install jupyterlab
```


```SHELL
$ jupyter lab --ip 0.0.0.0

[I 2023-07-26 17:59:54.819 ServerApp] jupyterlab | extension was successfully linked.
[I 2023-07-26 17:59:54.828 ServerApp] Writing Jupyter server cookie secret to /home/ubuntu/.local/share/jupyter/runtime/jupyter_cookie_secret
[I 2023-07-26 17:59:55.090 ServerApp] nbclassic | extension was successfully linked.
[I 2023-07-26 17:59:55.115 ServerApp] nbclassic | extension was successfully loaded.
[I 2023-07-26 17:59:55.116 LabApp] JupyterLab extension loaded from /home/ubuntu/environment/delab/delab-venv/lib/python3.6/site-packages/jupyterlab
[I 2023-07-26 17:59:55.116 LabApp] JupyterLab application directory is /home/ubuntu/environment/delab/delab-venv/share/jupyter/lab
[I 2023-07-26 17:59:55.120 ServerApp] jupyterlab | extension was successfully loaded.
[I 2023-07-26 17:59:55.121 ServerApp] Serving notebooks from local directory: /home/ubuntu/environment/delab
[I 2023-07-26 17:59:55.121 ServerApp] Jupyter Server 1.13.1 is running at:
http://127.0.0.1:8888/lab?token=2614abe261cd501fa56acdcac10e86b1c943c00a59b89d013
```

- Port seems like 8888
- Token will be use when jupyter is up and running first time.
- Open Cloud9 new terminal.

```SHELL
$ telnet localhost 8888
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
```

- We have to go running e2c instance and click, and go to Security Tab, click Security Group
- Review Inbound Rules
- Find Inbound Rules
- Edit Inbound Rules
- Add Rule
- Type : Custom TCP
- Port : 8888
- Source: My IP ( it means, It will get your IP address, and it will connect only you.)
- Save Rule.
- Click on running EC2 instance
- Find, Copy -> Public IPv4 DNS -> and paste to the browser. Add :8888 port end of DNS


- Now we can see the jupyter.
- Paste token and login.
- Now you can use juphyter lab.

8 - Click Notebook Pyhon3

Write and hit ctrl + enter

```python
print('hello world')
```

hello world

```python
from platform import python_version
python_version()
```


- Go to E2C instance terminal
- Ctrl  C to exit

9 - Jupyter Lab running on background.

If you would like to run Jupyter Lab as a background process 

```SHELL
$ nohup jupyter lab --ip 0.0.0.0 &
```

Let's see token 

```SHELL
$ tail nohup.out
or
$ view nohup.out 
``` 

Close Jupyter Lab

```SHELL
$ jobs
$ fg
$ crtl - c 
```



10 - Introduction to Single Node Hadoop Cluster

- Cloud9
- Search on the bar
- open terminal

```SHELL
$ sudo apt-get install wget
```




