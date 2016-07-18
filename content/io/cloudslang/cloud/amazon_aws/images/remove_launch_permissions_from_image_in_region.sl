#   (c) Copyright 2016 Hewlett-Packard Enterprise Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#!!
#! @description: Removes launch permission of the specified AMI.
#!               Note: The 'user_ids' and 'user_groups' inputs cannot be left both empty in order to remove permission
#!                     launch on specified image.
#!                     AWS Marketplace product codes cannot be modified. Images with an AWS Marketplace product code
#!                     cannot be made public.
#! @input provider: Cloud provider on which you have the image - Default: 'amazon'
#! @input endpoint: Endpoint to which first request will be sent - Default: 'https://ec2.amazonaws.com'
#! @input identity: optional - Amazon Access Key ID
#! @input credential: optional - Amazon Secret Access Key that corresponds to the Amazon Access Key ID
#! @input proxy_host: optional - Proxy server used to access the provider services
#! @input proxy_port: optional - Proxy server port used to access the provider services - Default: '8080'
#! @input region: optional - Region where the targeted image reside. ListRegionAction can be used in order to get
#!                           all regions. For further details check: http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
#!                         - Default: 'us-east-1'
#! @input image_id: ID of the specified image to remove launch permission for
#! @input user_ids_string: optional - A string that contains: none, one or more user IDs separated by delimiter
#!                                  - Default: ''
#! @input user_groups_string: optional - A string that contains: none, one or more user groups separated by delimiter
#!                                     - Default: ''
#! @output return_result: contains the exception in case of failure, success message otherwise
#! @output return_code: '0' if operation was successfully executed, '-1' otherwise
#! @output error_message: error message if there was an error when executing, empty otherwise
#! @result SUCCESS: the image was successfully created
#! @result FAILURE: an error occurred when trying to create image
#!!#
####################################################
namespace: io.cloudslang.cloud.amazon_aws.images

operation:
  name: remove_launch_permissions_from_image_in_region

  inputs:
    - provider: 'amazon'
    - endpoint: 'https://ec2.amazonaws.com'
    - identity:
        default: ''
        required: false
        sensitive: true
    - credential:
        default: ''
        required: false
        sensitive: true
    - proxy_host:
        required: false
    - proxyHost:
        default: ${get("proxy_host", "")}
        private: true
    - proxy_port:
        required: false
    - proxyPort:
        default: ${get("proxy_port", "8080")}
        private: true
    - region:
        default: 'us-east-1'
        required: false
    - image_id
    - imageId: ${image_id}
    - user_ids_string:
        required: false
    - userIdsString:
        default: ${get("user_ids_string", "")}
        private: true
    - user_groups_string:
        required: false
    - userGroupsString:
        default: ${get("user_groups_string", "")}
        private: true

  java_action:
    gav: 'io.cloudslang.content:cs-jClouds:0.0.6'
    class_name: io.cloudslang.content.jclouds.actions.images.RemoveLaunchPermissionsFromImageAction
    method_name: execute

  outputs:
    - return_result: ${returnResult}
    - return_code: ${returnCode}
    - exception: ${get("exception", "")}

  results:
    - SUCCESS: ${returnCode == '0'}
    - FAILURE
