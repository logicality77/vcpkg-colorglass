vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO CharmedBaryon/CommonLibSSE
        REF 2cfc609da1f981ac0814a216e55fd243df199975
        SHA512 2b7a18151b5f4f445f516c911234cf901a7cc49b7b43bd8bd62070a7eb78468d8a46ae1ec0a46acde69f4d7b5de8287c3ec4ce58d93c0d07ca94263c6d64b4b7
        HEAD_REF main
)

vcpkg_configure_cmake(
        SOURCE_PATH "${SOURCE_PATH}"
        PREFER_NINJA
        OPTIONS -DENABLE_SKYRIM_VR=off -DENABLE_SKYRIM_SE=off -DBUILD_TESTS=off -DSKSE_SUPPORT_XBYAK=on
)

vcpkg_install_cmake()
vcpkg_cmake_config_fixup(PACKAGE_NAME CommonLibSSE CONFIG_PATH lib/cmake)
vcpkg_copy_pdbs()

file(GLOB CMAKE_CONFIGS "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE/*.cmake")
file(INSTALL ${CMAKE_CONFIGS} DESTINATION "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE")
file(INSTALL "${SOURCE_PATH}/cmake/CommonLibSSE.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/CommonLibSSE/CommonLibSSE")

file(
        INSTALL "${SOURCE_PATH}/LICENSE"
        DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
        RENAME copyright)
