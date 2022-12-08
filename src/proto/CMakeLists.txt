# Begin Protobuf Definitions
set(PROTO_FILES
        duration.proto
        timestamp.proto
        basic_types.proto
        transaction.proto
        transaction_body.proto
        transaction_contents.proto
        ethereum_transaction.proto
        consensus_create_topic.proto
        consensus_delete_topic.proto
        consensus_get_topic_info.proto
        consensus_service.proto
        consensus_submit_message.proto
        consensus_topic_info.proto
        consensus_update_topic.proto
        contract_call.proto
        contract_call_local.proto
        contract_create.proto
        contract_delete.proto
        contract_get_bytecode.proto
        contract_get_info.proto
        contract_get_records.proto
        contract_update.proto
        crypto_add_live_hash.proto
        crypto_approve_allowance.proto
        crypto_create.proto
        crypto_delete.proto
        crypto_delete_allowance.proto
        crypto_delete_live_hash.proto
        crypto_get_account_balance.proto
        crypto_get_account_records.proto
        crypto_get_info.proto
        crypto_get_live_hash.proto
        crypto_get_stakers.proto
        crypto_service.proto
        crypto_transfer.proto
        crypto_update.proto
        custom_fees.proto
        exchange_rate.proto
        file_append.proto
        file_create.proto
        file_delete.proto
        file_get_contents.proto
        file_get_info.proto
        file_service.proto
        file_update.proto
        freeze.proto
        freeze_service.proto
        freeze_type.proto
        get_account_details.proto
        get_by_key.proto
        get_by_solidity_id.proto
        network_get_execution_time.proto
        network_get_version_info.proto
        network_service.proto
        node_stake_update.proto
        query.proto
        query_header.proto
        response.proto
        response_code.proto
        response_header.proto
        schedulable_transaction_body.proto
        schedule_create.proto
        schedule_delete.proto
        schedule_get_info.proto
        schedule_service.proto
        schedule_sign.proto
        smart_contract_service.proto
        system_delete.proto
        system_undelete.proto
        throttle_definitions.proto
        token_associate.proto
        token_burn.proto
        token_create.proto
        token_delete.proto
        token_dissociate.proto
        token_fee_schedule_update.proto
        token_freeze_account.proto
        token_get_account_nft_infos.proto
        token_get_info.proto
        token_get_nft_info.proto
        token_get_nft_infos.proto
        token_grant_kyc.proto
        token_mint.proto
        token_pause.proto
        token_revoke_kyc.proto
        token_service.proto
        token_unfreeze_account.proto
        token_unpause.proto
        token_update.proto
        token_wipe_account.proto
        transaction_get_fast_record.proto
        transaction_get_receipt.proto
        transaction_get_record.proto
        transaction_receipt.proto
        transaction_record.proto
        transaction_response.proto
        unchecked_submit.proto
        util_prng.proto
        util_service.proto)
# End Protobuf Definitions

add_library(hapi STATIC ${PROTO_FILES})
target_link_libraries(hapi PRIVATE protobuf::libprotobuf gRPC::grpc gRPC::grpc++)
target_include_directories(hapi PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

#
# Compile protobuf and grpc files in the hapi target to cpp
#
get_target_property(grpc_cpp_plugin_location gRPC::grpc_cpp_plugin LOCATION)
protobuf_generate(TARGET hapi LANGUAGE cpp IMPORT_DIRS ${PROTO_SRC})
protobuf_generate(TARGET hapi LANGUAGE grpc GENERATE_EXTENSIONS .grpc.pb.h .grpc.pb.cc PLUGIN "protoc-gen-grpc=${grpc_cpp_plugin_location}" IMPORT_DIRS ${PROTO_SRC})

# Install Library & Headers
install(TARGETS hapi ARCHIVE DESTINATION lib LIBRARY DESTINATION lib RUNTIME DESTINATION bin)

#install(FILES ${ZLIB_LIBRARY_RELEASE} DESTINATION lib)
#install(FILES ${Protobuf_LIBRARY_RELEASE} DESTINATION lib)
#
#get_target_property(OPENSSL_CRYPTO_LIBRARY_RELEASE OpenSSL::Crypto LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(OPENSSL_SSL_LIBRARY_RELEASE OpenSSL::SSL LOCATION_LIBRARY_OUTPUT_RELEASE)
#
#install(FILES
#            ${OPENSSL_SSL_LIBRARY_RELEASE}
#            ${OPENSSL_CRYPTO_LIBRARY_RELEASE}
#        DESTINATION lib)
#
#
#get_target_property(GRPC_LIBRARY gRPC::grpc LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_ADDRESS_SORTING_LIBRARY gRPC::address_sorting LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_GPR_LIBRARY gRPC::gpr LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_PLUGIN_SUPPORT_LIBRARY gRPC::grpc_plugin_support LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_UNSECURE_LIBRARY gRPC::grpc_unsecure LOCATION_LIBRARY_OUTPUT_RELEASE)
#
#if(TARGET gRPC::grpcpp_channelz)
#    get_target_property(GRPC_PP_CHANNELZ_PROTO_LIBRARY gRPC::grpcpp_channelz LOCATION_LIBRARY_OUTPUT_RELEASE)
#endif()
#
#
#install(FILES
#            ${GRPC_LIBRARY}
#            ${GRPC_ADDRESS_SORTING_LIBRARY}
#            ${GRPC_GPR_LIBRARY}
#            ${GRPC_PLUGIN_SUPPORT_LIBRARY}
#            ${GRPC_PP_CHANNELZ_PROTO_LIBRARY}
#            ${GRPC_UNSECURE_LIBRARY}
#        DESTINATION lib)
#
#get_target_property(GRPC_CPP_LIBRARY gRPC::grpc++ LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_CPP_ALTS_LIBRARY gRPC::grpc++_alts LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_CPP_ERROR_DETAILS_LIBRARY gRPC::grpc++_error_details LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(GRPC_CPP_UNSECURE_LIBRARY gRPC::grpc++_unsecure LOCATION_LIBRARY_OUTPUT_RELEASE)
#
#if(TARGET gRPC::grpc++_reflection)
#    get_target_property(GRPC_CPP_REFLECTION_LIBRARY gRPC::grpc++_reflection LOCATION_LIBRARY_OUTPUT_RELEASE)
#endif()
#
#install(FILES
#            ${GRPC_CPP_LIBRARY}
#            ${GRPC_CPP_ALTS_LIBRARY}
#            ${GRPC_CPP_ERROR_DETAILS_LIBRARY}
#            ${GRPC_CPP_REFLECTION_LIBRARY}
#            ${GRPC_CPP_UNSECURE_LIBRARY}
#        DESTINATION lib)
#
#get_target_property(RE2_LIBRARY re2::re2 LOCATION_LIBRARY_OUTPUT_RELEASE)
#install(FILES ${RE2_LIBRARY} DESTINATION lib)
#
#get_target_property(CARES_LIBRARY c-ares::cares LOCATION_LIBRARY_OUTPUT_RELEASE)
#install(FILES ${CARES_LIBRARY} DESTINATION lib)
#
#get_target_property(UPB_LIBRARY upb::upb LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_COLLECTIONS_LIBRARY upb::collections LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_DESCRIPTOR_UPB_PROTO_LIBRARY upb::descriptor_upb_proto LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_EXTENSION_REGISTRY_LIBRARY upb::extension_registry LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_FASTDECODE_LIBRARY upb::fastdecode LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_JSON_LIBRARY upb::json LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_MINI_TABLE_LIBRARY upb::mini_table LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_REFLECTION_LIBRARY upb::reflection LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_TEXTFORMAT_LIBRARY upb::textformat LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(UPB_UTF8_RANGE_LIBRARY upb::utf8_range LOCATION_LIBRARY_OUTPUT_RELEASE)
#
#install(FILES
#            ${UPB_LIBRARY}
#            ${UPB_COLLECTIONS_LIBRARY}
#            ${UPB_DESCRIPTOR_UPB_PROTO_LIBRARY}
#            ${UPB_EXTENSION_REGISTRY_LIBRARY}
#            ${UPB_FASTDECODE_LIBRARY}
#            ${UPB_JSON_LIBRARY}
#            ${UPB_MINI_TABLE_LIBRARY}
#            ${UPB_REFLECTION_LIBRARY}
#            ${UPB_TEXTFORMAT_LIBRARY}
#            ${UPB_UTF8_RANGE_LIBRARY}
#        DESTINATION lib)
#
#get_target_property(ABSL_BAD_ANY_CAST_IMPL_LIBRARY absl::bad_any_cast_impl LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_BAD_OPTIONAL_ACCESS_LIBRARY absl::bad_optional_access LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_BAD_VARIANT_ACCESS_LIBRARY absl::bad_variant_access LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_BASE_LIBRARY absl::base LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CITY_LIBRARY absl::city LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CIVIL_TIME_LIBRARY absl::civil_time LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORD_LIBRARY absl::cord LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORD_INTERNAL_LIBRARY absl::cord_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORDZ_FUNCTIONS_LIBRARY absl::cordz_functions LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORDZ_HANDLE_LIBRARY absl::cordz_handle LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORDZ_INFO_LIBRARY absl::cordz_info LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_CORDZ_SAMPLE_TOKEN_LIBRARY absl::cordz_sample_token LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_DEBUGGING_INTERNAL_LIBRARY absl::debugging_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_DEMANGLE_INTERNAL_LIBRARY absl::demangle_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_EXAMINE_STACK_LIBRARY absl::examine_stack LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_EXPONENTIAL_BIASED_LIBRARY absl::exponential_biased LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FAILURE_SIGNAL_HANDLER_LIBRARY absl::failure_signal_handler LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_LIBRARY absl::flags LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_COMMANDLINEFLAG_LIBRARY absl::flags_commandlineflag LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_COMMANDLINEFLAG_INTERNAL_LIBRARY absl::flags_commandlineflag_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_CONFIG_LIBRARY absl::flags_config LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_INTERNAL_LIBRARY absl::flags_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_MARSHALLING_LIBRARY absl::flags_marshalling LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_PARSE_LIBRARY absl::flags_parse LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_PRIVATE_HANDLE_ACCESSOR_LIBRARY absl::flags_private_handle_accessor LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_PROGRAM_NAME_LIBRARY absl::flags_program_name LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_REFLECTION_LIBRARY absl::flags_reflection LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_USAGE_LIBRARY absl::flags_usage LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_FLAGS_USAGE_INTERNAL_LIBRARY absl::flags_usage_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_GRAPHCYCLES_INTERNAL_LIBRARY absl::graphcycles_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_HASH_LIBRARY absl::hash LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_HASHTABLEZ_SAMPLER_LIBRARY absl::hashtablez_sampler LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_INT128_LIBRARY absl::int128 LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_LEAK_CHECK_LIBRARY absl::leak_check LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_LOG_SEVERITY_LIBRARY absl::log_severity LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_LOW_LEVEL_HASH_LIBRARY absl::low_level_hash LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_MALLOC_INTERNAL_LIBRARY absl::malloc_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_PERIODIC_SAMPLER_LIBRARY absl::periodic_sampler LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_DISTRIBUTIONS_LIBRARY absl::random_distributions LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_DISTRIBUTION_TEST_UTIL_LIBRARY absl::random_internal_distribution_test_util LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_PLATFORM_LIBRARY absl::random_internal_platform LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_POOL_URBG_LIBRARY absl::random_internal_pool_urbg LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_RANDEN_LIBRARY absl::random_internal_randen LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_RANDEN_HWAES_LIBRARY absl::random_internal_randen_hwaes LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_RANDEN_HWAES_IMPL_LIBRARY absl::random_internal_randen_hwaes_impl LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_RANDEN_SLOW_LIBRARY absl::random_internal_randen_slow LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_INTERNAL_SEED_MATERIAL_LIBRARY absl::random_internal_seed_material LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_SEED_GEN_EXCEPTION_LIBRARY absl::random_seed_gen_exception LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RANDOM_SEED_SEQUENCES_LIBRARY absl::random_seed_sequences LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RAW_HASH_SET_LIBRARY absl::raw_hash_set LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_RAW_LOGGING_INTERNAL_LIBRARY absl::raw_logging_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_SCOPED_SET_ENV_LIBRARY absl::scoped_set_env LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_SPINLOCK_WAIT_LIBRARY absl::spinlock_wait LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STACKTRACE_LIBRARY absl::stacktrace LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STATUS_LIBRARY absl::status LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STATUSOR_LIBRARY absl::statusor LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STR_FORMAT_INTERNAL_LIBRARY absl::str_format_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STRERROR_LIBRARY absl::strerror LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STRINGS_LIBRARY absl::strings LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_STRINGS_INTERNAL_LIBRARY absl::strings_internal LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_SYMBOLIZE_LIBRARY absl::symbolize LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_SYNCHRONIZATION_LIBRARY absl::synchronization LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_THROW_DELEGATE_LIBRARY absl::throw_delegate LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_TIME_LIBRARY absl::time LOCATION_LIBRARY_OUTPUT_RELEASE)
#get_target_property(ABSL_TIME_ZONE_LIBRARY absl::time_zone LOCATION_LIBRARY_OUTPUT_RELEASE)
#
#install(FILES
#            ${ABSL_BAD_ANY_CAST_IMPL_LIBRARY}
#            ${ABSL_BAD_OPTIONAL_ACCESS_LIBRARY}
#            ${ABSL_BAD_VARIANT_ACCESS_LIBRARY}
#            ${ABSL_BASE_LIBRARY}
#            ${ABSL_CITY_LIBRARY}
#            ${ABSL_CIVIL_TIME_LIBRARY}
#            ${ABSL_CORD_LIBRARY}
#            ${ABSL_CORD_INTERNAL_LIBRARY}
#            ${ABSL_CORDZ_FUNCTIONS_LIBRARY}
#            ${ABSL_CORDZ_HANDLE_LIBRARY}
#            ${ABSL_CORDZ_INFO_LIBRARY}
#            ${ABSL_CORDZ_SAMPLE_TOKEN_LIBRARY}
#            ${ABSL_DEBUGGING_INTERNAL_LIBRARY}
#            ${ABSL_DEMANGLE_INTERNAL_LIBRARY}
#            ${ABSL_EXAMINE_STACK_LIBRARY}
#            ${ABSL_EXPONENTIAL_BIASED_LIBRARY}
#            ${ABSL_FAILURE_SIGNAL_HANDLER_LIBRARY}
#            ${ABSL_FLAGS_LIBRARY}
#            ${ABSL_FLAGS_COMMANDLINEFLAG_LIBRARY}
#            ${ABSL_FLAGS_COMMANDLINEFLAG_INTERNAL_LIBRARY}
#            ${ABSL_FLAGS_CONFIG_LIBRARY}
#            ${ABSL_FLAGS_INTERNAL_LIBRARY}
#            ${ABSL_FLAGS_MARSHALLING_LIBRARY}
#            ${ABSL_FLAGS_PARSE_LIBRARY}
#            ${ABSL_FLAGS_PRIVATE_HANDLE_ACCESSOR_LIBRARY}
#            ${ABSL_FLAGS_PROGRAM_NAME_LIBRARY}
#            ${ABSL_FLAGS_REFLECTION_LIBRARY}
#            ${ABSL_FLAGS_USAGE_LIBRARY}
#            ${ABSL_FLAGS_USAGE_INTERNAL_LIBRARY}
#            ${ABSL_GRAPHCYCLES_INTERNAL_LIBRARY}
#            ${ABSL_HASH_LIBRARY}
#            ${ABSL_HASHTABLEZ_SAMPLER_LIBRARY}
#            ${ABSL_INT128_LIBRARY}
#            ${ABSL_LEAK_CHECK_LIBRARY}
#            ${ABSL_LOG_SEVERITY_LIBRARY}
#            ${ABSL_LOW_LEVEL_HASH_LIBRARY}
#            ${ABSL_MALLOC_INTERNAL_LIBRARY}
#            ${ABSL_PERIODIC_SAMPLER_LIBRARY}
#            ${ABSL_RANDOM_DISTRIBUTIONS_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_DISTRIBUTION_TEST_UTIL_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_PLATFORM_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_POOL_URBG_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_RANDEN_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_RANDEN_HWAES_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_RANDEN_HWAES_IMPL_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_RANDEN_SLOW_LIBRARY}
#            ${ABSL_RANDOM_INTERNAL_SEED_MATERIAL_LIBRARY}
#            ${ABSL_RANDOM_SEED_GEN_EXCEPTION_LIBRARY}
#            ${ABSL_RANDOM_SEED_SEQUENCES_LIBRARY}
#            ${ABSL_RAW_HASH_SET_LIBRARY}
#            ${ABSL_RAW_LOGGING_INTERNAL_LIBRARY}
#            ${ABSL_SCOPED_SET_ENV_LIBRARY}
#            ${ABSL_SPINLOCK_WAIT_LIBRARY}
#            ${ABSL_STACKTRACE_LIBRARY}
#            ${ABSL_STATUS_LIBRARY}
#            ${ABSL_STATUSOR_LIBRARY}
#            ${ABSL_STR_FORMAT_INTERNAL_LIBRARY}
#            ${ABSL_STRERROR_LIBRARY}
#            ${ABSL_STRINGS_LIBRARY}
#            ${ABSL_STRINGS_INTERNAL_LIBRARY}
#            ${ABSL_SYMBOLIZE_LIBRARY}
#            ${ABSL_SYNCHRONIZATION_LIBRARY}
#            ${ABSL_THROW_DELEGATE_LIBRARY}
#            ${ABSL_TIME_LIBRARY}
#            ${ABSL_TIME_ZONE_LIBRARY}
#        DESTINATION lib)
#
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR} DESTINATION include FILES_MATCHING PATTERN "*.h")
#install(DIRECTORY ${Protobuf_INCLUDE_DIRS} DESTINATION ${CMAKE_INSTALL_PREFIX})
#install(DIRECTORY ${ZLIB_INCLUDE_DIRS} DESTINATION ${CMAKE_INSTALL_PREFIX})
