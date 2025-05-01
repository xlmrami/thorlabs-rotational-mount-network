# Thorlabs Rotational Mount Controller (MATLAB + APT)

This repository provides a flexible MATLAB interface to control multiple Thorlabs rotational mounts using **ActiveX** and the **APT** driver. It enables GUI-based and programmable control over multiple motors using custom motor template scripts.

## 🔧 Features

- Control multiple Thorlabs motors simultaneously
- GUI for manual control of each mount
- Built-in support for saving/loading motor angles
- Rotate to **absolute** or **relative** positions
- Compatible with QWP/HWP and other optical components
- Extendable by duplicating `MotorTemplate.m` for each new motor

## 🧰 Requirements

- MATLAB R2019b or later (with ActiveX support)
- [Thorlabs APT Drivers](https://www.thorlabs.com/software_pages/ViewSoftwarePage.cfm?Code=Motion_Control)
- Thorlabs-compatible motor hardware
- Windows OS (ActiveX only)

## 📁 Structure

- `ThorlabRotationalMount.m`: Main class that manages all motors
- `MotorTemplate.m`: Template to create individual motor control GUIs
- `SavedAngles.txt`: File storing the last saved motor positions
- Custom scripts like `ClassCrossPolPair.m` instantiate and use the controller

## 🚀 Example Usage

```matlab
clear; clc;

handle = ClassCrossPolPair();  % Custom wrapper that uses ThorlabRotationalMount
handle.connect();              % Initializes motors and moves to home
```

## 🔀 Example Commands

```matlab
handle.Rotate_POS(90, 1);           % Move motor 1 to 90°
handle.Rotate_Relative(-10, 2);     % Move motor 2 by -10°
angle = handle.get_Angle(1);        % Read current angle of motor 1
handle.Save_Data();                 % Save all motor angles
handle.Go_to_Last_All();           % Restore all saved angles
handle.CloseConnectionClear();      % Disconnect all motors
```

## 📌 Setup Instructions

1. **Download and install APT software** from Thorlabs (link above).
2. Ensure the motor serial numbers are correctly entered in each custom `MotorTemplateX.m`.
3. Update the `Path` property in `ThorlabRotationalMount.m` to point to your script folder.
4. Place `SavedAngles.txt` in the same folder.

## 🖼️ GUI

Running each motor template launches a separate GUI control panel for each motor. You can manually move, adjust velocity, and configure settings via the GUI.

## 📬 Contact

Developed by **Rami Lameche**  
📧 xlmrami@gmail.com
