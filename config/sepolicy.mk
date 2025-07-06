# Include LineageOS SEPolicy 
ifneq ($(wildcard device/lineage/sepolicy/common/sepolicy.mk),)
  $(eval include device/lineage/sepolicy/common/sepolicy.mk)
endif

# Include Halcyon SEPolicy
ifneq ($(wildcard device/halcyon/sepolicy/sepolicy.mk),)
  $(eval include device/halcyon/sepolicy/sepolicy.mk)
endif