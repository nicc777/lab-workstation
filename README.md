# Lab Workstation

The purpose of this Docker system is to emulate a user's workstation.

It may be handy for people needing to demonstrate console usage and commands from a "clean" workstation. 

From a workstation perspective, users will start the Docker workstation and then SSH in with user account(s) as required.

The intention is that this project be used as a boiler plate for users to modify as required.

The latest official Ubuntu image is used as base. Some basic utilities and services will be installed - be sure to adapt the Docker configuration to suite your needs.

## Step 1: Building the base image

The base image is used to add more packages to a local image. This can take some time depending on individual needs, and since this is not required to be done with each workstation image modification, the base is prepared separately.

Include all other Ubuntu packages you require in  `src/base/Dockerfile`.

Also include any other ports you need exposing as well as volumes that need to be shared.

Once the file is ready, prepare with:

```bash
$ cd src/base
$ docker build -t lab_ws_base --no-cache .
```

## Step 2: Preparing for the workstation build

In the `src/workstation` directory is a couple of files:

| File         | What it is used for                                            |
|--------------|----------------------------------------------------------------|
| `service.sh` | This file will be run with when the container starts           |
| `bashrc_add` | Contains any additional lines to be added to /etc/skel/.bashrc |

You can edit these files and add more to fit your scenario.

Also edit the Dockerfile to add any additional configurations you need.

## Step 3: Workstation build and first run

Finally, run the following:

```bash
$ cd ../workstation
$ docker build -t workstation --no-cache .
```

After the build have completed the workstation can be run. The following command will start the workstation in daemon mode (`-d` switch), with some resource limits and the SSH port mapped to a local port 2022. Adjust to your needs:

```bash
$ docker run --name workstation -m 512m --cpus=1.0 -p 127.0.0.1:2022:22 -d workstation
$ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
3e990d97d10a        workstation         "/bin/sh -c /opt/ser…"   6 seconds ago       Up 6 seconds        127.0.0.1:2022->22/tcp   workstation
```

## Stopping and restarting the workstation (no Dockerfile modifications)

Should the need arise to stop the workstation and later start it again, this can easily be accomplished with the following commands:

* `docker container stop workstation` - Stops the workstation
* `docker container start workstation` - Start the workstation again

## Rebuilding after modifications to any source files

Ensure the running container is stopped and then delete it.

```bash
$ docker container stop workstation
$ docker container rm workstation
```

Next, if modifications to the base Dockerfile was made, loop back to step 1 and also complete steps 2 and 3. If only the workstation source files were modified, do steps 2 and 3 only.

## Logging in the workstation and exploring

Logging in:

```bash
$ ssh -p 2022 user01@127.0.0.1
user01@127.0.0.1's password: 
Welcome to Ubuntu 18.04.4 LTS (GNU/Linux 4.19.76-linuxkit x86_64)

 ... some output omitted

Hi user01. you can now use the system

user01@3e990d97d10a:~$ 
```

Test connectivity to the outside world:

```bash
$ ping -c 3 www.google.com
PING www.google.com (172.217.15.196) 56(84) bytes of data.
64 bytes from mia09s20-in-f4.1e100.net (172.217.15.196): icmp_seq=1 ttl=37 time=231 ms
64 bytes from mia09s20-in-f4.1e100.net (172.217.15.196): icmp_seq=2 ttl=37 time=258 ms
64 bytes from mia09s20-in-f4.1e100.net (172.217.15.196): icmp_seq=3 ttl=37 time=258 ms

--- www.google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 231.517/249.443/258.440/12.675 ms
```

In the default `bashrc_add` file an alias to the `ls` command was added and the result can be seen below:

```bash
$ ls
total 28K
-rw-r--r-- 1 user01 user01  807 Apr  4  2018 .profile
-rw-r--r-- 1 user01 user01  220 Apr  4  2018 .bash_logout
-rw-r--r-- 1 user01 user01 3.8K Apr  8 16:57 .bashrc
drwxr-xr-x 1 root   root   4.0K Apr  8 16:57 ..
drwx------ 2 user01 user01 4.0K Apr  8 17:00 .cache
drwxr-xr-x 1 user01 user01 4.0K Apr  8 17:00 .
```

Get the version of the `kubectl` client:

```bash
$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.1", GitCommit:"7879fc12a63337efff607952a323df90cdc7a335", GitTreeState:"clean", BuildDate:"2020-04-08T17:38:50Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
```

## Conclusion

I hope this is useful to someone "out there". Let me know if you want to see more features added by logging an issue.

Have fun!
