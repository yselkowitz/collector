DEFAULT_GOAL = all

COLLECTOR_QA_BENCHMARK_TAG := phoronix

ifneq ($(COLLECTOR_QA_TAG),)
COLLECTOR_QA_BENCHMARK_TAG=phoronix-$(COLLECTOR_QA_TAG)
endif

PLATFORMS_ALL := --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x
# for make push
PUSH_ARG :=

.PHONY: all
all:
	@docker buildx build $(PLATFORMS_ALL) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_BENCHMARK_TAG) .

.PHONY: push
push:
	$(MAKE) all PUSH_ARG=--push
