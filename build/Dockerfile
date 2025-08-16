ARG IMAGE="mcr.microsoft.com/dotnet/sdk:8.0-jammy"
FROM $IMAGE
#LABEL author="https://github.com/aBARICHELLO/godot-ci/graphs/contributors"

USER root
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    git-lfs \
    unzip \
    wget \
    zip \
    openjdk-17-jdk-headless \
    adb \
    rsync \
    wine64 \
    osslsigncode \
    && rm -rf /var/lib/apt/lists/*

# When in doubt, see the downloads page: https://github.com/godotengine/godot-builds/releases/
ARG GODOT_VERSION="4.4.1"

# Example values: stable, beta3, rc1, dev2, etc.
# Also change the `SUBDIR` argument below when NOT using stable.
ARG RELEASE_NAME="stable"

# This is only needed for non-stable builds (alpha, beta, RC)
# e.g. SUBDIR "/beta3"
# Use an empty string "" when the RELEASE_NAME is "stable".
ARG SUBDIR=""

ARG GODOT_TEST_ARGS=""
ARG GODOT_PLATFORM="linux.x86_64"

# NOTE: Mono downloads use an underscore instead of a dot between `linux` and `x86_64` in their URL
# and folder name within the ZIP, but not in the binary file name within the ZIP.
ARG GODOT_ZIP_PLATFORM="linux_x86_64"

#RUN wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip \
#    && wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
#    && mkdir -p ~/.cache \
#    && mkdir -p ~/.config/godot \
#    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono \
#    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip \
#    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_PLATFORM} /usr/local/bin/godot \
#    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/GodotSharp /usr/local/bin/GodotSharp \
#    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
#    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono \
#    && rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip


#
# Downloads the binary
# Downloads the EXPORT configs for all targets
#
RUN echo "[step 1] wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip" \
    && wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip \
    && echo "[step 1] Completed" \
    && echo "[step 2] wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz" \
    && wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
    && echo "[step 2] Completed" \
    && echo "[step 3] mkdir -p ~/.cache" \
    && mkdir -p ~/.cache \
    && echo "[step 3] Completed" \
    && echo "[step 4] mkdir -p ~/.config/godot" \
    && mkdir -p ~/.config/godot \
    && echo "[step 4] Completed" \
    && echo "[step 5] mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono" \
    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono \
    && echo "[step 5] Completed" \
    && echo "[step 6] unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip" \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip \
    && echo "[step 6] Completed" \
    && echo "[step 7] mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_PLATFORM} /usr/local/bin/godot" \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_PLATFORM} /usr/local/bin/godot \
    && echo "[step 7] Completed" \
    && echo "[step 8] mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/GodotSharp /usr/local/bin/GodotSharp" \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}/GodotSharp /usr/local/bin/GodotSharp \
    && echo "[step 8] Completed" \
    && echo "[step 9] unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz" \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz \
    && echo "[step 9] Completed" \
    && echo "[step 10] mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono" \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}.mono \
    && echo "[step 10] Completed" \
    && echo "[step 11] rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip" \
    && rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_mono_${GODOT_ZIP_PLATFORM}.zip \
    && echo "[step 11] Completed"

#RUN godot -v -e --quit --headless ${GODOT_TEST_ARGS}
