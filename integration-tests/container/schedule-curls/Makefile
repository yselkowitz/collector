.DEFAULT_GOAL = all

COLLECTOR_QA_SCHEDULE_CURLS_TAG := collector-schedule-curls

ifneq ($(COLLECTOR_QA_TAG),)
COLLECTOR_QA_SCHEDULE_CURLS_TAG=collector-schedule-curls-$(COLLECTOR_QA_TAG)
endif

PLATFORMS_ALL := --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x
# for make push
PUSH_ARG :=

.PHONY: all
all:
	@docker buildx build $(PLATFORMS_ALL) $(PUSH_ARG) -t quay.io/rhacs-eng/qa:$(COLLECTOR_QA_SCHEDULE_CURLS_TAG) .

.PHONY: push
push:
	$(MAKE) all PUSH_ARG=--push
