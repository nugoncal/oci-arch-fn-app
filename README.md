# Deploy an event-triggered serverless application
A deployable solution for event-triggered serverless application on Oracle Cloud Infrastructure.

## Pre-Requisites

- You need an Oracle cloud account. Sign up here to create a free trial on OCI - [OCI free trial link](https://www.oracle.com/cloud/free/)

- Terraform — use the link to download terraform. Choose the operating systems you plan to work on - [Terraform download](https://www.terraform.io/downloads.html)

- Follow the steps in the video link to install terrafor - [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)

(Note that, for linux and mac install steps are similar, except the file to be edited shown in the video link is —> `profile` for linux and `bash_profile` for mac)

Verify terraform is installed successfully using below command.

`terraform --version`

## Deploying the solution

### Step 1: Updating the configuration files

This solution uses Terraform to spin up the infrastructure.

Go ahead and clone this repo using below command.

`git clone https://github.com/oracle-quickstart/oci-arch-fn-app.git`

Once you clone, open in your machine using your favorite editor. (Vim, Sublime, VSCode, Atom etc.)

In the opened editor, edit the file `env.sh` to fill in the details specific to your account on OCI.

#### *** Optional Step ***

In `vars.tf` file, if you would like to change default values provided for terraform variables, please go ahead and update it.

When all the variables are set, you are ready to run the terraform script.

### Step 2: Running the script for infrastructure provisioning

On the terminal or command line, make sure you are inside the working directory. If not, cd into the folder `oci-arch-ci-cd` using below command

`cd oci-arch-fn-app`

Let’s export all the variables from `env.sh` into current directory.

`source env.sh`

Initialize terraform using below command

`terraform init`

Plan the terraform using below command

`terraform plan`

Apply Terraform using below command

`terraform apply`

It will prompt ***Enter a value***. Type ***yes***

This will start creating the resources on OCI and might take ~15 min to finish the job.

The terraform script creates all the necessery infrastructure components including  Networking, Compute Instance and Function on OCI.

Once it completes, you should be able to login to OCI and see all the resources provisioned as expected in terraform.

### Step 3: Configure OCI-CLI

Go to OCI console -> Compute -> Instances.

You should be able to see the instance `function-server-instance`

Copy the public-ip of the instance. ssh into the instance using below command

`ssh -i <path-to-ssh-private-key> opc@<public-ip-of-function-server-instance>`

once you are logged in, make sure OCI-CLI is installed using 

`oci -v`

Next, enter the command `oci setup config`

Press Enter when prompted for directory name to accept the default. 
Enter the details about tenancy OCID, user OCID.
Enter `Y` for `New RSA key pair`. Press Enter and accept default options for directories. 
Press Enter when prompted for passphrase so as to leave it blank.

Verify all the files exists by checking in -> `cd /home/opc/.oci` and then `ls`.

Also, do `cat config` and make sure all the details about tenancy are correct.

Now, do `cat oci_api_key_public.pem` and copy the key contents. 

Login to OCI console, go to your profile and user. Click on `Add Public Key` and copy paste the contents of the file copied in last step. Now make sure the `fingerprint` generated is same as the one in Jenkins server `/home/opc/.oci/config` file.

We are done.

### Step 4: Add user to group

Go to OCI console -> Identity -> Groups.

You should be able to see the group `faas-group`

Click on `Add User to Group` at bottom. This opens up a new window.

Choose your username from the dropdown and add it.

## Step 5: Generate OCIR token

Login to OCI console.

Click on your `Profile` -> `User Settings`. On the bottom left, click on `Auth Tokens`. Click on `Generate Token`.

Provide a discription and then hit `Generate Token`. This will generate a token. Make sure to copy the token and save it for future steps.

## Step 6: Run function commands to setup

Log in to instance `ssh -i <path-to-ssh-private-key> opc@<public-ip-of-function-server-instance>`

Run the below commands one after another. Make sure to edit the values when necessery.

`fn create context my-context --provider oracle`
`fn use context my-context`
`fn update context oracle.compartment-id "<COMPARTMENT-OCID>"`
`fn update context api-url https://functions.us-ashburn-1.oraclecloud.com`
`fn update context registry iad.ocir.io/<OCI_NAMESPACE>/acme-repo`
`fn update context oracle.profile DEFAULT`
`fn init --runtime java cloud-events-demo-fn`

## Step 7: Update the code and deploy the function

On the logged instance, do `ls` and now you should see the folder `cloud-events-demo-fn` that contains a boiler template code.

Lets delete the test code for now.

Run -> `rm /home/opc/cloud-events-demo-fn/src/test/java/com/example/fn/HelloFunctionTest.java`

Next, cd into the folder -> `cd cloud-events-demo-fn`

Edit the `pom.xml` and `/home/opc/cloud-events-demo-fn/src/main/java/com/example/fn/HelloFunction.java` file. Go to below link and copy the content for the corresponding files and replace them in `pom.xml` and `HelloFunction.java` files. 

*** Imp Note ***

Before we deploy the function, please type `exit` from instance and ssh back in.

Now, its time to deploy the function.

`docker login iad.ocir.io`

Enter the username and password when asked.

Username -> <your-tenancy-namespace>/oracleidentitycloudservice/<abc@xyz.com (use your email here)> (look for namespace in tenancy details for <your-tenancy-namespace>)
Password -> OCIR token we had created in Step 5

Start the docker service

`sudo service docker start`

Next do, `cd cloud-events-demo-fn`

Now deploy the function using below commands.

`fn --verbose deploy --app cloud-events-demo`

## Step 8: Create an event service

Login to OCI console. 

Click on OCI object storage on the left side bar, create a bucket named `bucket` and make sure to enable `emit events` as shown below.

Next, To create a new cloud event rule, click on Application Integration -> Events Service in the sidebar menu

Click on 'Create Rule' and populate the form as shown below.


Also, go to created function `cloud-events-demo` and make sure to enable the logs as shown below on OCI console.


## Step 9: Invoking the function

On the object storage bucket we just created named `bucket`, upload a sample image, as shown below.

## Step 10: Verification

The uploaded image triggers the event, which invokes the function. The logs of the metadata about the object are written to object storage. Wait for ~10 for the logs to appear in the object storage.

You can see the logs as shown below and also download it for reference.

## Step 11: Delete the resources

Finally, if you like to destroy all the created resources, run below command from where you were running terraform code before.

`terraform destroy`

It will prompt ***Enter a value***. Type ***yes***

This completes the deployment.