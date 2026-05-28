from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class IAMWildcardAccessCheck(BaseResourceCheck):
    def __init__(self):
        name = "Ensure IAM policies do not allow wildcard access"

        id = "CUSTOM_AWS_004"

        supported_resources = ["aws_iam_policy"]

        categories = [CheckCategories.IAM]

        super().__init__(
            name=name,
            id=id,
            categories=categories,
            supported_resources=supported_resources,
        )

    def scan_resource_conf(self, conf):

        policy = conf.get("policy")

        if not policy:
            return CheckResult.PASSED

        policy_content = str(policy)

        if '"Action":"*"' in policy_content:
            return CheckResult.FAILED

        if '"Resource":"*"' in policy_content:
            return CheckResult.FAILED

        return CheckResult.PASSED


check = IAMWildcardAccessCheck()
