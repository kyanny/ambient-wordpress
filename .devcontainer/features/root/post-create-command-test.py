def test_awscli_is_installed(host):
    cmd = host.run("aws --version")
    version = cmd.stdout.split()[0].split("/")[1]
    assert cmd.stdout.startswith("aws-cli")
    assert version.startswith("2.13.1")

def test_githubcli_is_installed(host):
    cmd = host.run("gh --version")
    version = cmd.stdout.split()[2]
    assert cmd.stdout.startswith("gh")
    assert version.startswith("2.32.0")

def test_jqlikes_is_installed(host):
    cmd = host.run("jq --version")
    version = cmd.stdout.split("-")[1]
    assert cmd.stdout.startswith("jq")
    assert version.startswith("1.6")

def test_python_is_installed(host):
    cmd = host.run("python --version")
    version = cmd.stdout.split()[1]
    assert cmd.stdout.startswith("Python")
    assert version.startswith("3.9.17")