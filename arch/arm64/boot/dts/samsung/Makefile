ifeq ($(CONFIG_BUILD_ARM64_DT_OVERLAY),y)

ifeq ($(filter y,$(CONFIG_SEC_A52Q_PROJECT)),y)
# A52Q EUR
SEC_A52Q_EUR_DTBO := \
		atoll-sec-a52q-eur-overlay-r00.dtbo \
		atoll-sec-a52q-eur-overlay-r01.dtbo \
		atoll-sec-a52q-eur-overlay-r02.dtbo \
		atoll-sec-a52q-eur-overlay-r04.dtbo \
		atoll-sec-a52q-eur-overlay-r05.dtbo \
		atoll-sec-a52q-eur-overlay-r06.dtbo

# A52Q LTN
SEC_A52Q_LTN_DTBO := \
		atoll-sec-a52q-ltn-overlay-r04.dtbo \
		atoll-sec-a52q-ltn-overlay-r05.dtbo \
		atoll-sec-a52q-ltn-overlay-r06.dtbo
else ifeq ($(filter y,$(CONFIG_SEC_A72Q_PROJECT)),y)
# A72Q EUR
SEC_A72Q_EUR_DTBO := \
		atoll-sec-a72q-eur-overlay-r00.dtbo \
		atoll-sec-a72q-eur-overlay-r01.dtbo \
		atoll-sec-a72q-eur-overlay-r02.dtbo \
		atoll-sec-a72q-eur-overlay-r04.dtbo \
		atoll-sec-a72q-eur-overlay-r05.dtbo

# A72Q LTN
SEC_A72Q_LTN_DTBO := \
		atoll-sec-a72q-ltn-overlay-r00.dtbo \
		atoll-sec-a72q-ltn-overlay-r01.dtbo \
		atoll-sec-a72q-ltn-overlay-r02.dtbo \
		atoll-sec-a72q-ltn-overlay-r04.dtbo \
		atoll-sec-a72q-ltn-overlay-r05.dtbo
else ifeq ($(filter y,$(CONFIG_SEC_GTA4XLVE_PROJECT)),y)
# GTA4XLVE EUR
SEC_GTA4XLVE_EUR_DTBO := \
		atoll-sec-gta4xlve-eur-overlay-r00.dtbo

# GTA4XLVEWIFI EUR
SEC_GTA4XLVEWIFI_EUR_DTBO := \
		atoll-sec-gta4xlvewifi-eur-overlay-r00.dtbo
# GTA4XLVE KOR
SEC_GTA4XLVE_KOR_DTBO := \
		atoll-sec-gta4xlve-kor-overlay-r00.dtbo

# GTA4XLVE CHN
SEC_GTA4XLVE_CHN_DTBO := \
		atoll-sec-gta4xlve-chn-overlay-r00.dtbo

# GTA4XLVEWIFI CHN
SEC_GTA4XLVEWIFI_CHN_DTBO := \
		atoll-sec-gta4xlvewifi-chn-overlay-r00.dtbo
endif
define __sec_dtbo_build
dtbo-$(2) += $(1)
$(1)-base := $(3)
endef

define sec_dtbo_build
$(foreach dtbo, $(1), $(eval $(call __sec_dtbo_build, $(dtbo),$(2),$(3))))
endef

# SM7125 BASE DTB
SEC_ATOLL_BASE_DTB := ../qcom/atoll-ab-idp.dtb

ifeq ($(filter y,$(CONFIG_SEC_A52Q_PROJECT)),y)
$(eval $(call sec_dtbo_build, \
		$(SEC_A52Q_EUR_DTBO),$(CONFIG_SEC_A52Q_EUR_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_A52Q_LTN_DTBO),$(CONFIG_SEC_A52Q_LTN_OPEN),$(SEC_ATOLL_BASE_DTB)))
else ifeq ($(filter y,$(CONFIG_SEC_A72Q_PROJECT)),y)
$(eval $(call sec_dtbo_build, \
		$(SEC_A72Q_EUR_DTBO),$(CONFIG_SEC_A72Q_EUR_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_A72Q_LTN_DTBO),$(CONFIG_SEC_A72Q_LTN_OPEN),$(SEC_ATOLL_BASE_DTB)))
else ifeq ($(filter y,$(CONFIG_SEC_GTA4XLVE_PROJECT)),y)
$(eval $(call sec_dtbo_build, \
		$(SEC_GTA4XLVE_EUR_DTBO),$(CONFIG_SEC_GTA4XLVE_EUR_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_GTA4XLVEWIFI_EUR_DTBO),$(CONFIG_SEC_GTA4XLVEWIFI_EUR_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_GTA4XLVE_KOR_DTBO),$(CONFIG_SEC_GTA4XLVE_KOR_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_GTA4XLVE_CHN_DTBO),$(CONFIG_SEC_GTA4XLVE_CHN_OPEN),$(SEC_ATOLL_BASE_DTB)))

$(eval $(call sec_dtbo_build, \
		$(SEC_GTA4XLVEWIFI_CHN_DTBO),$(CONFIG_SEC_GTA4XLVEWIFI_CHN_OPEN),$(SEC_ATOLL_BASE_DTB)))
endif
endif

ifeq ($(CONFIG_ARM64),y)
always          := $(dtb-y)
subdir-y        := $(dts-dirs)
else
targets += dtbs
targets += $(addprefix ../, $(dtb-y))

$(obj)/../%.dtb: $(src)/%.dts FORCE
        $(call if_changed_dep,dtc)

dtbs: $(addprefix $(obj)/../,$(dtb-y))
endif

clean-files := *.dtb *.dtbo
