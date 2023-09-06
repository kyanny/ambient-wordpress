SHELL=/bin/bash

login: configure sso-login mfa finally
	@aws-export-credentials --credentials-file-profile amplify

configure:
	@/workspace/.devcontainer/features/root/aws-configure.sh $(ENV)

sso-login:
	@if [ ! -z "${AWS_SSO_ACCOUNT_ID}" ]; then \
		echo "aws sso login" ; \
		aws sso login ; \
	fi

mfa:
	@if [ ! -z "${AWS_MFA_ASSUME_ROLE}" ] && [ ! -z "${AWS_MFA_DEVICE}" ]; then \
		echo "aws-mfa" ; \
		aws-mfa --profile default --assume-role ${AWS_MFA_ASSUME_ROLE} --role-session-name default-role-session --device ${AWS_MFA_DEVICE} --duration $${AWS_MFA_DURATION:43200} ; \
	fi

clean:
	@rm -rf node_modules

reset:
	@git checkout .
	@git reset --hard HEAD
	@git clean -df

finally:
	@aws sts get-caller-identity

# ------------------------- guard -------------------------------
guard-%:
	@if [ "$($(*))" = "" ]; then \
		echo "\033[7;31menv variable $* not set; add valiable '$*=<hoge>'\033[0;39m"; \
		exit 1; \
	fi