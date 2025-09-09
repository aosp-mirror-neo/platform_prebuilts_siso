This directory contains prebuilt binaries of [Siso](https://chromium.googlesource.com/build/+/main/siso/README.md) which are used by Soong.

Process for updating the prebuilts:

1. Choose a `git_revision` to update to. You can either take the revision from the [latest build](https://chrome-infra-packages.appspot.com/p/build/siso/linux-amd64/+/latest) of Siso or choose one from [git history](https://source.chromium.org/chromium/build).

1. Update the `siso.ensure` file in this directory with the new tag value. All of the platforms should be updated to the same `git_revision` for consistency.

1. Update the Siso prebuilts by running
   ```
   $ ./update_siso_prebuilts.sh
   ```

1. Commit the change to git. If new platforms were added, make sure to `git add` the new files.
