vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO color-glass/CommonLibSSE
        REF d292ed7ce7cc039428fb6e2a4583dfe6ce29da67
        SHA512 6f620a46141f451e5d754c3fc27ac4616a3d474c47b5d74bdf9b97222096c059506e8c6001bd2659746130b9757830ca96c4d45cca3c32ee901120014eea840c
        HEAD_REF dev
)

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

vcpkg_configure_cmake(
        SOURCE_PATH "${SOURCE_PATH}"
        PREFER_NINJA
        OPTIONS -DSKYRIM_SUPPORT_AE=on -DSKSE_SUPPORT_XBYAK=on
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
