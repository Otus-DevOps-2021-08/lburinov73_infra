#!/bin/env python3

import sys
import json
import optparse
import grpc
import yandexcloud
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub
from yandex.cloud.compute.v1.instance_service_pb2 import ListInstancesRequest


def cmd_host(host):
    return {}


def cmd_list(sdk, folder_id):
    instance_service = sdk.client(InstanceServiceStub)
    instances = instance_service.List(
        ListInstancesRequest(folder_id=folder_id, page_size=1000)
    )
    meta_hostvars = dict()
    groups = dict()
    for instance in instances.instances:
        nat_ipv4 = instance.network_interfaces[
            0].primary_v4_address.one_to_one_nat.address
        if instance.status != 2 or str(nat_ipv4) == "":
            continue
        parts = instance.name.split("-")
        for part in parts:
            groups.setdefault(part, {}).setdefault("hosts",
                                                   []).append(instance.name)
        groups.setdefault("all", {}).setdefault("hosts",
                                                []).append(instance.name)
        meta_hostvars[instance.name] = {"ansible_host": nat_ipv4}

    return {"_meta": {"hostvars": meta_hostvars}, **groups}


def main():
    parser = optparse.OptionParser()
    parser.add_option(
        '--list',
        action='store_true',
        dest='list',
        default=False,
        help='list instances'
    )
    parser.add_option(
        '--host',
        dest='host',
        default=None,
        help='list vars for an instance (unimplemented)'
    )
    parser.add_option(
        '--folder',
        dest='folder',
        default='b1g4httodue8h1h7tgnf',
        help='yc folder id'
    )
    options, args = parser.parse_args()

    interceptor = yandexcloud.RetryInterceptor(
        max_retry_count=5, retriable_codes=[grpc.StatusCode.UNAVAILABLE]
    )
    with open("/home/leo/otus-devops/key.json") as keyfile:
        sdk = yandexcloud.SDK(
            interceptor=interceptor, service_account_key=json.load(keyfile)
        )

    if options.host is not None:
        result = cmd_host(options.host)
    else:
        result = cmd_list(sdk, options.folder)

    json.dump(result, sys.stdout, indent=4, sort_keys=True)


if __name__ == '__main__':
    main()
