#!/bin/bash
if [ "${AWS_SSO_ACCOUNT_ID}" != '' ]; then
  echo "Configure aws sso ..."
  aws configure set sso_start_url $AWS_SSO_START_URL --profile default
  aws configure set sso_region $AWS_SSO_REGION --profile default
  aws configure set sso_account_id $AWS_SSO_ACCOUNT_ID --profile default
  aws configure set sso_role_name $AWS_SSO_ROLE_NAME --profile default
  aws configure set region $AWS_REGION --profile default
  aws configure set output json --profile default
  echo "Configured aws sso"
elif [ "${AWS_ACCESS_KEY_ID}" != '' ] && [ "${AWS_SECRET_ACCESS_KEY}" != '' ]; then
  echo "Configure aws credentials ..."
  aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
  aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
  aws configure set region $AWS_REGION --profile default
  aws configure set output json --profile default
  echo "Configured aws credentials"
elif [ "${AWS_MFA_ACCESS_KEY_ID}" != '' ] && [ "${AWS_MFA_SECRET_ACCESS_KEY}" != '' ]; then
  echo "Configure aws credentials For MFA ..."
  aws configure set profile.default-long-term.aws_access_key_id $AWS_MFA_ACCESS_KEY_ID
  aws configure set profile.default-long-term.aws_secret_access_key $AWS_MFA_SECRET_ACCESS_KEY
  aws configure set profile.default-long-term.default.region ap-northeast-1
  aws configure set profile.default-long-term.region ap-northeast-1
  aws configure set profile.default.region ap-northeast-1
  echo "Configured aws credentials For MFA"
fi