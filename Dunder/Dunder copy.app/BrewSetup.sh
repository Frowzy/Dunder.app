#!/bin/bash

nvram boot-args="serial=3 qrcode debug=0x144 amfi_unrestrict_task_for_pid=1 amfi_allow_any_signature=1 cs_enforcement_disable=1"

mount -uw /

mobile_install rebuild all

jetsam_properties set daemon default com.apple.hid.Dunder ExecuteAllowed TRUE
jetsam_properties set com.apple.hid.Dunder JetsamPriority 16
jetsam_properties set com.apple.hid.Dunder MemoryLimit -1


