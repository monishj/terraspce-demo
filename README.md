Certainly! If you prefer installing Terraspace without using RubyGems on macOS, you can use Homebrew. Here's an updated version of the README:

## Terraspace - Getting Started

## Overview

[Terraspace](https://terraspace.cloud/) is a tool designed to make working with Terraform easier. It simplifies the development, deployment, and testing of Terraform infrastructure.

## Prerequisites

Before you start using Terraspace, ensure you have the following prerequisites installed:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (version >= 2.5)
- [Terraform](https://www.terraform.io/) (version >= 0.12)
- [AWS CLI](https://aws.amazon.com/cli/) (for AWS deployments)

## Installation

### 1. Install Homebrew

If you don't have Homebrew installed, install it using the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Terraspace

Use Homebrew to install Terraspace:

```bash
brew tap boltops-tools/tap
brew install terraspace
```

## Getting Started

### 1. Create a New Terraspace Project

Create a new Terraspace project using the following command:

```bash
terraspace new my_project
cd my_project
```

### 2. Configure the Environment

Navigate to the project directory and configure your environment. Terraspace supports multiple environments (e.g., dev, prod). Customize the configuration in `config/dev/terraform.tfvars`.

### 3. Write Terraform Code

Write your Terraform infrastructure code in the `app/stacks` directory. Terraspace follows a convention over configuration approach, organizing stacks by environment.

### 4. Deploy the Infrastructure

Deploy your infrastructure using the following command:

```bash
terraspace up STACK
```

Replace `STACK` with the name of your Terraform stack.

### 5. Destroy the Infrastructure

When you're done, destroy the infrastructure with:

```bash
terraspace down STACK
```

Replace `STACK` with the name of your Terraform stack.

## Additional Commands

- `terraspace all up/down`: Deploy or destroy all stacks.
- `terraspace summary`: Display a summary of all stacks and their outputs.

For more information, refer to the [Terraspace documentation](https://terraspace.cloud/docs/getting-started/install).

## Example Project Structure

```plaintext
.
├── app
│   └── stacks
│       └── example
│           ├── main.tf
│           └── variables.tf
├── config
│   └── dev
│       └── terraform.tfvars
├── Gemfile
└── .terraspace.yml
```

Adjust the project structure based on your needs and the complexity of your infrastructure.