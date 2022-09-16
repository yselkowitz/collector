.DEFAULT_GOAL = all

COLLECTOR_QA_INIT_TAG := init
COLLECTOR_QA_PERF_TAG := perf
COLLECTOR_QA_BCC_TAG := bcc
COLLECTOR_QA_BPFTRACE_TAG := bpftrace

ifneq ($(COLLECTOR_QA_TAG),)
COLLECTOR_QA_INIT_TAG=init-$(COLLECTOR_QA_TAG)
COLLECTOR_QA_PERF_TAG=perf-$(COLLECTOR_QA_TAG)
COLLECTOR_QA_BCC_TAG=bcc-$(COLLECTOR_QA_TAG)
COLLECTOR_QA_BPFTRACE_TAG=bpftrace-$(COLLECTOR_QA_TAG)
endif

PLATFORMS_ALL := --platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x
# add linux/ppc64le when updating base to alpine:3.17
PLATFORMS_BCC := --platform linux/amd64,linux/arm64
# iovisor/bpftrace is not multi-arch
PLATFORMS_BPF := --platform linux/amd64,linux/arm64,linux/ppc64le
# for make push
PUSH_ARG :=

.PHONY: all
all:
	@docker buildx build $(PLATFORMS_ALL) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_INIT_TAG) --target init -f Dockerfile .
	@docker buildx build $(PLATFORMS_ALL) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_PERF_TAG) --target perf -f Dockerfile .
	@docker buildx build $(PLATFORMS_BCC) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_BCC_TAG) --target bcc -f Dockerfile .
	@docker buildx build $(PLATFORMS_BPF) $(PUSH_ARG) -t quay.io/rhacs-eng/collector-performance:$(COLLECTOR_QA_BPFTRACE_TAG) -f Dockerfile.bpftrace .

.PHONY: push
push:
	$(MAKE) all PUSH_ARG=--push
