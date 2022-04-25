# Camera Engine Readme


We are using Git-Flow:
http://nvie.com/posts/a-successful-git-branching-model/

## Azul Migration Notes  
Core Media team introduced a new framework called **CMCapture** to consolidate all the *Fig** headers in MediaToolbox and CoreMedia starting Azul 18A232.  

#### Impact on Camera Engine
Camera Engine needs to link against CMCapture framework to work on Azul, and against MediaToolbox/CoreMedia on YukonE. Unfortunately since CMCapture is not part of YukonE SDK, we would get a linker error in any Xcode with YukonE or prior iOS SDKs.

#### Workaround
To allow CE clients to build and run on *YukonE as well as Azul* we:
- Added a dummy **CMCapture** framework of our own in the repo at: `$(PROJECT_DIR)/External\ Frameworks`
- Added `$(PROJECT_DIR)/External\ Frameworks` to the `framework search path` in the project's build settings below the system framework path (to load the dummy CMCapture **if** the original one is not found).
- Verified that the symbols being linked are loaded from the correct frameworks (CMCapture on Azul, MediaToolbox/CoreMedia in YukonE).

#### Impact on Users
You should be able to build and use Camera Engine as before, as long as you:
- Build on an Xcode with **YukonE** SDK, *if you want to run on **YukonE**.*
- Build on an Xcode with **Azul** SDK, *if you want to run on **Azul**.*


#### Due to the availability of **CMCapture** only after Azul 18A232, **Camera Engine will not support any Azul builds < 18A232**

## Changelog

### 4.2.2.2
- ST3 platform support
- H13 based device support.

### 4.2.1  
- Added compile time checks to avoid linking against YukonE specific properties.
- Added more robus error checking at FigCaptureDevice level.

### 4.2  
- Added support for point cloud outputs (that deliver CVDataBuffers)
- Format indexes can now be looked up using a set of lookup params instead of passing the index directly.

### 4.1  
- Added support for ToF identifiers from CM
- Removed forced check of specified sync master to be same as the sync group's master

### v4.0.3
- Removed a forced check to map BackJasper Stream Type to the relevant port type only on specific platforms.

### v4.0.2
- Added convenience functions for set/copy FigCaptureSynchronizedStreamsGroupRef associated with a CaptureStream.

### v4.0.1
- Modified manualAE function signature to take in framerate as well (else the FW ignores the min/max framerates)
