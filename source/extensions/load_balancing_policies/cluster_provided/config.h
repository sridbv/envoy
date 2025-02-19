#pragma once

#include <memory>

#include "envoy/extensions/load_balancing_policies/cluster_provided/v3/cluster_provided.pb.h"
#include "envoy/upstream/load_balancer.h"

#include "source/common/upstream/load_balancer_factory_base.h"

namespace Envoy {
namespace Extensions {
namespace LoadBalancingPolices {
namespace ClusterProvided {

class Factory
    : public Upstream::TypedLoadBalancerFactoryBase<
          envoy::extensions::load_balancing_policies::cluster_provided::v3::ClusterProvided> {
public:
  Factory() : TypedLoadBalancerFactoryBase("envoy.load_balancing_policies.cluster_provided") {}

  Upstream::ThreadAwareLoadBalancerPtr create(const Upstream::ClusterInfo& cluster_info,
                                              const Upstream::PrioritySet& priority_set,
                                              Runtime::Loader& runtime,
                                              Random::RandomGenerator& random,
                                              TimeSource& time_source) override;
};

} // namespace ClusterProvided
} // namespace LoadBalancingPolices
} // namespace Extensions
} // namespace Envoy
