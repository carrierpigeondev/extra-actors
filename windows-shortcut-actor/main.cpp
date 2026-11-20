// uses Windows library and therefore needs an appropriate compiler
//
// I am using mingw64-gcc for my Fedora Linux development (see the
// buildall.bash file in the parent directory of this project).

#include <windows.h>
#include <shellapi.h>
#include <shobjidl.h>


/// according to API spec:
///   - argv[0] : program name
///   - argv[1] : "link"
///   - argv[2] : Output Scrypt Path
///   - argv[3] : Output Symlink Path
int main()
{
    int argc;
    LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);

    if (argc >= 4)
    {
        CoInitialize(nullptr);

        IShellLinkW* link;
        CoCreateInstance(CLSID_ShellLink, nullptr, CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&link));
        link->SetPath(argv[2]);

        IPersistFile* file;
        link->QueryInterface(IID_PPV_ARGS(&file));
        file->Save(argv[3], TRUE);

        file->Release();
        link->Release();
        CoUninitialize();
    }

    LocalFree(argv);
    return 0;
}