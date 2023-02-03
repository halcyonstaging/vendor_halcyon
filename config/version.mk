#
# Copyright (C) 2020 The conquerOS Project
#           (C) 2023 The Halcyon Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

HALCYON_HOST_TIME := $(shell date +"%Y%m%d-%H%M")

HALCYON_BUILD_TYPE ?= BETA

HALCYON_VERSION := Tithonia
HALCYON_VERSION_NUMBER := 13.0

HALCYON_BUILD_VERSION := halcyon_$(HALCYON_BUILD)-$(HALCYON_VERSION)-$(HALCYON_HOST_TIME)-$(HALCYON_BUILD_TYPE)
HALCYON_BUILD_NUMBER := $(HALCYON_VERSION).$(HALCYON_VERSION_NUMBER).$(HALCYON_HOST_TIME)

# Halcyon Build information properties
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.halcyon.version=$(HALCYON_VERSION) \
   ro.halcyon.build.version=$(HALCYON_BUILD_VERSION) \
   ro.halcyon.build.number=$(HALCYON_BUILD_NUMBER) \
   ro.halcyon.build.type=$(HALCYON_BUILD_TYPE)
