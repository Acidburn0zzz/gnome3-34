// This file is part of GNOME Boxes. License: LGPLv2+

using GVirConfig;

private class Boxes.LibvirtMedia : Boxes.InstalledMedia {
    protected override string? architecture {
        owned get {
            return domain_config.get_os ().get_arch ();
        }
    }

    public Domain domain_config { get; private set; }

    public LibvirtMedia (string path, Domain domain_config, bool known_qcow2 = false) throws GLib.Error {
        base (path, known_qcow2);

        this.domain_config = domain_config;
        label = domain_config.title?? domain_config.name;

        // Just initializing for sake for completion (and to avoid crashes). The CPU & RAM config comes from the
        // imported domain and storage volume is overwritten as well.
        resources = OSDatabase.get_default_resources ();
    }

    public override VMCreator get_vm_creator () {
        return new LibvirtVMImporter (this);
    }
}
