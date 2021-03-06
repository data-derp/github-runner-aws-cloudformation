# Github Runner Bootstrap
This repository creates a Github Runner (self-hosted) on AWS for a single Github Repository. 

**Warning:** this template creates AWS resources which incur costs.

This Cloudformation template sets up the following:
* A Single VPC, NAT Gateway, IG, Private/Public Subnet, VPC Endpoints to ensure private networking
* GithubRunner attached to your specified Github repository 

## Setup
1. Add this to your **PRIVATE** Github repository as a submodule: `git submodule add git@github.com:data-derp/github-runner-aws-cloudformation.git`
   * This module creates AWS Resources. If added to a public repository, anyone can fork and use the Github Runner and create AWS Resources.
2. [Create a Github Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with the Repo Scope. This will be used to generate a token to register a GithubRunner.
![github-repo-scope](./assets/github-repo-scope.png)
3. Set up your AWS CLI and authenticate to your AWS account and store those credentials in a named AWS profile (make sure it's active `export AWS_PROFILE=<your-profile>`)
4. **OPTIONAL:** Switch your role (only if requred).  For those expected to assume a role (within the same account) to perform AWS operations, there is a helper function:
   ```bash
   ./github-runner-aws-cloudformation/switch-role -b <starting-profile> -t <target-role>
   ```
   This uses credentials in your `-b <starting-profile>` to switch into the `-t <target-role>`. You can now use the target role's credentials by using the AWS_PROFILE `data-derp`
   ```bash
   export AWS_PROFILE=data-derp
   ```
5. Create the Stack. 
   ```bash
   ./github-runner-aws-cloudformation/create-stack -p <your-project-name> -m <your-team-name> -r <aws-region> -u <your-github-username>
   ```
   :bulb: the `your-project-name` and `your-team-name` must be globally unique as an AWS S3 bucket is created (this resource is globally unique)

6. When prompted, enter your Personal Access Token (created in step 1)
   ```bash
   Enter host password for user 'your-github-username': <the-personal-access-token>
   ```

7. View your [Cloudformation Stacks in the AWS Console](https://eu-central-1.console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks)

8. When you're done, self-destruct your Github Runner:
   ```bash
   ./github-runner-aws-cloudformation/delete-stack -p <your-project-name> -m <your-team-name> -r <aws-region>
   ```
## Future Development
- [x] Delete Stack (and SSM Param) script
- [x] Handle different AWS regions