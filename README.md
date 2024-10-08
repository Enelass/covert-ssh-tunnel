 # Hacking - Breach Internal Corporate Network 

Overview
--------

 This Bash script is intended for offensive security purposes, specifically to evade corporate network boundaries via a single outbound connection, which can be kept alive using tools like **autossh**.
 It evades detection by using port 443, which is typically allowed as it is commonly used for HTTPS traffic.
 This script is designed to create and manage SSH tunnels, particularly for setting up SOCKS proxies and port forwarding. It includes functions to set up SOCKS proxies for both Firefox and system-wide use on macOS.

Author
------

*   **Name**: Florian Bidabe
    
*   **Date**: Written sometime in 2009, most likely.

License
-------

This script is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

Security Controls
-----------------

To avoid data breaches from insiders, the following security controls should be implemented:

*   **Next-Generation Firewall (NGFW) with Application Fingerprinting**: To detect and block unauthorized applications and traffic.
    
*   **Log and Event Monitoring**: To monitor and analyze logs for suspicious activities.
    
*   **Outbound Traffic Whitelisting and Inspection**: To ensure that only authorized traffic is allowed out of the network and to inspect the traffic for any anomalies.
    

Purpose
-------

This script is shared to enable organizations to better protect themselves by understanding the techniques used to bypass network security measures. By understanding these methods, organizations can implement more robust security controls to detect and prevent such activities.

Features
--------

*   **SOCKS Proxy Setup**: Creates a SOCKS proxy via SSH, ensuring that a tunnel is created only if one does not already exist.
    
*   **Firefox SOCKS Proxy**: Configures Firefox to use the SOCKS proxy for secure browsing.
    
*   **System-Wide SOCKS Proxy**: Toggles the system-wide SOCKS proxy settings on macOS.
    
*   **Port Forwarding**: Supports local and remote port forwarding.
    
*   **Dynamic Port Forwarding**: Allows dynamic port forwarding for more flexible tunneling.
    

Usage
-----

The script provides a menu-driven interface to select various options for setting up SSH tunnels and SOCKS proxies. The options include:

*   **Default SSH Command**: Copies the default SSH command to the clipboard.
    
*   **Local Port Forwarding**: Prompts for a port number and sets up local port forwarding. Common ports include:
    
    *   Server.app (311)
        
    *   Web (80, 443)
        
    *   VNC (5900) for graphical remote control
        
    *   File Sharing: AFP (548) or SMB/CIFS
        
    *   Databases
        
    *   Mail
        
*   **Remote Port Forwarding**: Prompts for a port number and sets up remote port forwarding.
    
*   **Dynamic Port Forwarding**: Allows dynamic port forwarding for more flexible tunneling.
    
*   **Kill Existing Tunnel**: Kills existing SSH tunnels.
    

Requirements
------------

*   **Operating System**: macOS X (can be easily ported to other Unix-based or Windows systems)
    
*   **SSH Client**: **ssh** command-line tool
    
*   **Firefox**: For browser-specific SOCKS proxy configuration
    
*   **Networksetup**: macOS command-line tool for network configuration
    
*   **Autossh**: Optional, for keeping SSH connections alive
    

Disclaimer
----------

This script is intended for educational and defensive purposes only. Unauthorized access to computer systems is illegal and unethical. Always ensure you have explicit permission before using any offensive security tools or techniques.

Contributing
------------

If you find any issues or have suggestions for improvements, please feel free to contribute by opening an issue or submitting a pull request.

License
-------

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
