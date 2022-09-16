.DEFAULT_GOAL = all

COLLECTOR_QA_STATS_TAG := stats

ifneq ($(COLLECTOR_QA_TAG),)
COLLECTOR_QA_STATS_TAG=stats-$(COLLECTOR_QA_TAG)
endif

# docker:dind is only available on these platforms
PLATFORMS_DIND := --platform linux/amd64,linux/arm64
# for make push
PUSH_ARG :=


.PHONY: all
all:
	@docker buildx build $(PLATFORMS_DIND) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_STATS_TAG) .

.PHONY: push
push:
	$(MAKE) all PUSH_ARG=--push
