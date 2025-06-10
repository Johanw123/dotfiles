# Work 
winget install --id=Microsoft.VisualStudio.2022.Professional  -e
winget install Microsoft.VisualStudio.2022.BuildTools

winget install Microsoft.VisualStudio.2022.Professional --override "--quiet --add Microsoft.VisualStudio.Component.ManagedDesktop.Core"
winget install Microsoft.VisualStudio.2022.Professional --override "--quiet --add Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites"
winget install Microsoft.VisualStudio.2022.Professional --override "--quiet --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core"

winget install Microsoft.VCRedist.2015+.x64
winget install Microsoft.VCRedist.2015+.x86
winget install --id=Nvidia.CUDA -v "12.2.2" -e

winget install --id=Ollama.Ollama -e

winget install --id=Ccache.Ccache  -e

Start-Process powershell -ArgumentList  "-noprofile", "-command ccache -M 10G"
Start-Process powershell -ArgumentList  "-noprofile", "-command ccache -o compression_level=5"



