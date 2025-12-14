## <span id="section1-0">1.0 - Getting Started</span> (***MUST READ!***)
**Yes, a section of the manual is labeled as "*MUST READ!*" That's a clue. Many, if not most, basic support issues or usability complaints stem from improperly set expectations and/or lack of adherence to recommendations.**

**Before you get started, ask yourself:**

- Why am I interested in arcOS?
- What do I hope arcOS helps me accomplish?
- How do I think arcOS can help me?

**As you think about your answers, consider these core arcOS principles:**

- arcOS, ***when used as recommended***, provides a working baseline of fundamental digital communications software.
- arcOS facilitates rapid team based learning, experimentation, and troubleshooting.
- arcOS ***does not*** provide the knowledge needed to use the software or perform modifications.

### <span id="section1-1">1.1 - Hardware Requirements/Recommendations</span>
- **Laptop/Desktop Computer (x86_64 with min. 8GB RAM)**
- **USB Drive (min. 16GB, USB 3.0 *strongly* recommended)**
- **Digirig Mobile + Cable (Lite and DR891 *NOT* supported)**
- **Transceiver (must be Digirig compatible)**
- **GPS Receiver (*strongly* recommended)**

> **Developer Note:**
> 8GB RAM is sufficient for "normal" usage. Advanced users may require more RAM in order to take advantage of some features. Likewise, a 16GB USB drive may not provide the amount of persistent storage desired. For the purposes of use with arcOS, the "CAT Config" of the Digirig does not matter (Logic level, RS232, CI-V, TX500).
>
> Some popular transceivers are equipped with an internal soundcard. That's cool! arcOS doesn't care. arcOS depends on the use of a Digirig Mobile device as the computer-to-radio interface to offer "just works" functionality. Many of the transceivers with internal soundcards are also supported by one or more Digirig cables. Please conduct your own research to find an appropriate cable for your transceiver. If you choose to proceed with using the internal soundcard instead of a Digirig, any complaints of "it didn't just work!" will most likely be ignored.
>
> The Digirig Lite and DR891 are not supported due to the use of CM108 PTT (which is not supported by all included applications) and their specific transceiver requirement, respectively.
>
> While a GPS receiver is not strictly required, it is extremely useful in "off-grid" situations for maintaining an accurate system clock. Some applications may also use the provided GPS location if it is available.

**Used machines pulled from corporate environments are great candidates for arcOS! Here are some "known good" machines:**

> **Dell (Laptops):** Latitude 7280, 7400
>
> **Lenovo (Desktops):** ThinkCentre M715q, M73
>
> **Lenovo (Laptops):** ThinkPad T450, T480, X250, X1C5, X1C6 **/** Yoga 6

[Back to top](#top)

### <span id="section1-2">1.2 - First Boot Experience</span>
**The first time arcOS is booted, any free space on the USB device is configured as an exFAT filesystem (`/arcHIVE`) to be used as persistent storage. Any files not saved in this partition will be lost when the system is powered off/rebooted.**

Once booted, you'll see a **"Select Operator"** screen. On the first boot, it will be blank, and you should select **"Add new..."**. This will lead to the **"Station Setup"** screen. Here, you should enter your callsign and your Maidenhead grid square (min. 4 characters: `EM65`). If you have a GPS receiver attached to the system, and it has a valid location fix, the calculated gridsquare may be pre-populated.

Additionally, **"Station Setup"** presents you with a choice of **"QRV Profile"** (a set of user-saved configurations for one or more applications that will be used with a particular purpose in mind). The **"QRV Profile"** defaults to `NONE`, since you've not created any profiles yet. 

If you wish to use the VARA modems, in the **"VARA"** field select **"ENABLED"**. 

Click **"OK"**, and arcOS will configure the session using the callsign and gridsquare provided. The **"CORE"** modules will be deployed for the first time, and this stage may take a few minutes. On subsequent boots, this **"CORE"** modules deployment will likely be much faster. This slowness is due to the first deployment requiring the creation of some filesystems on the USB device.

If you enabled VARA, the installers will run during the first deployment. You should click through the installers, leaving all inputs as their default value. The VARA installers will not need to run on subsequent boots.

Once arcOS is ready for use, you'll see a pop-up notification that says **"N0CALL is QRV!"**

[Back to top](#top)

### <span id="section1-3">1.3 - Persistent Storage and Configurations</span>
**Some applications are configured to use persistence by default, and others allow for selective saving of configurations.**

**Applications/utilities which are persistent by default include:**

- Firefox (Web Browser)
- Thunderbird (Email Client)
- `$HOME/.ssh` (SSH keys and config files)
- `$HOME/.gnupg` (GPG keys and config files)
- Calendar
- Sticky Notes
- Applications added to the panel

**For applications/utilities which offer selective persistence, please browse the "Main Menu > arcOS Tools" category.**

> **Developer Note:** A good first step as a new arcOS user would be to connect to a Wi-Fi network, then use the **"arcOS Tools > Save Wi-Fi Connection"** utility to ensure that arcOS reconnects to that network after a reboot. A good second step would be to add your Winlink password to the Pat Winlink client, via the **"Action > Configure"** utility in Pat. Once set, use **"arcOS Tools > Save Pat Winlink Config"** to save the settings to a QRV Profile named **"DEFAULT"**. Now, after a reboot, your arcOS session will remember the Wi-Fi network, and the Pat Winlink client will remember your password.
>
> **When naming QRV Profiles, avoid spaces and special characters (hyphens and underscores work well).**

[Back to top](#top)

### <span id="section1-4">1.4 - Seeking Support</span>
**Support is available primarily via GitHub. [Discussions](https://github.com/kg4vdk/arcos-linux-modules/discussions) can be started and [issues](https://github.com/kg4vdk/arcos-linux-modules/issues) raised when necessary.**

When seeking ***DEVELOPER SUPPORT***, consider whether your question/issue is specific to arcOS. Generic questions about "Linux" or "ApplicationXYZ" should be directed to a more appropriate support forum.

When seeking ***ANY SUPPORT***, you are expected to provide details about what you have already tried/investigated, as well as any context necessary for readers to comprehend your issue or idea.

> **Developer Note:** If you are unable to provide evidence of effort, you might consider submitting a [donation](https://www.paypal.com/donate/?hosted_button_id=4SAKRN2MH7NEW) along with your support request.

[Back to top](#top)

---
