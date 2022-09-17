vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO color-glass/CommonLibSSE
        REF b615976354c18615adc713c1a8e4e2f3eee6d0ed
        SHA512 9268cde50f5de99bb8004a48559880645bebe8bb4784176a6f0f71865bebfd3d048ba76d8d1d26e4b309c388ccbd9a05e3c1ca1c90cf4ef8ee162a3682063fd3
        HEAD_REF dev
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_configure_cmake(
        SOURCE_PATH "${SOURCE_PATH}"
        PREFER_NINJA
        OPTIONS -DSKSE_SUPPORT_XBYAK=on
)

vcpkg_install_cmake()
vcpkg_cmake_config_fixup(PACKAGE_NAME CommonLibSSE CONFIG_PATH lib/cmake)
vcpkg_copy_pdbs()

file(GLOB CMAKE_CONFIGS "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE/*.cmake")
file(INSTALL ${CMAKE_CONFIGS} DESTINATION "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE")

file(
        INSTALL "${SOURCE_PATH}/LICENSE"
        DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
        RENAME copyright)
