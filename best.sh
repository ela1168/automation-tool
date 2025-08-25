#!/bin/bash

# -------------------------------
# Automated Pentest Script (4-Language)
# Fully multilingual
# -------------------------------

# -------------------------------
# Language Selection
# -------------------------------
select_language() {
    echo "Select language / ቋንቋ ይምረጡ / ቋንቋ ምረጽ / Afaan Oromoo filadhu:"
    echo "1) English"
    echo "2) አማርኛ (Amharic)"
    echo "3) ትግርኛ (Tigrinya)"
    echo "4) Afaan Oromoo"
    read -p "Choice: " lang_choice

    case $lang_choice in
        1) LANG_CHOICE="EN" ;;
        2) LANG_CHOICE="AM" ;;
        3) LANG_CHOICE="TI" ;;
        4) LANG_CHOICE="OR" ;;
        *) echo "Invalid choice, defaulting to English."; LANG_CHOICE="EN" ;;
    esac
}

# -------------------------------
# Multi-language Message Handler
# -------------------------------
msg() {
    case $1 in
        # Installation messages
        "installing_tools")
            case $LANG_CHOICE in
                EN) echo "[*] Installing required tools..." ;;
                AM) echo "[*] የሚፈልጉትን መሳሪያዎች እየጫ ኑ ነው..." ;;
                TI) echo "[*] እተወሰኑ መሳርሒታት እየተጭ ኑ ኣሎም..." ;;
                OR) echo "[*] Meeshaalee barbaachisan fe’amaa jiru..." ;;
            esac ;;
        "install_done")
            case $LANG_CHOICE in
                EN) echo "[*] Installation complete!" ;;
                AM) echo "[*] መጫኑ ተጠናቀቀ!" ;;
                TI) echo "[*] ጭነት ተዛዚሙ !" ;;
                OR) echo "[*] Fe’amuun xumurame!" ;;
            esac ;;
        # Menus
        "main_menu")
            case $LANG_CHOICE in
                EN) echo "MAIN MENU" ;;
                AM) echo "ዋና ማውጫ " ;;
                TI) echo "ዋና ምርጫ " ;;
                OR) echo "Sagantaa Guddaa" ;;
            esac ;;
        "recon_menu")
            case $LANG_CHOICE in
                EN) echo "RECONNAISSANCE MENU" ;;
                AM) echo "የሪኮን ምናሌ" ;;
                TI) echo "ሪኮን ምርጫ " ;;
                OR) echo "Filannoo Qorannoo" ;;
            esac ;;
        "bf_menu")
            case $LANG_CHOICE in
                EN) echo "BRUTE FORCE MENU" ;;
                AM) echo "የኃይል ጥቃት ምናሌ" ;;
                TI) echo "የኃይል ጥቃት ምርጫ " ;;
                OR) echo "Filannoo Humna Sarara" ;;
            esac ;;
        "dos_menu")
            case $LANG_CHOICE in
                EN) echo "DOS ATTACK (Simulation)" ;;
                AM) echo "የDOS ጥቃት " ;;
                TI) echo "የDOS ጥቃት (ምሳሌ)" ;;
                OR) echo "Dhiibbaa DoS (Fakkeenya)" ;;
            esac ;;
        # Invalid input
        "invalid") 
            case $LANG_CHOICE in
                EN) echo "Invalid option!" ;;
                AM) echo "የተሳሳተ ምርጫ!" ;;
                TI) echo "ኣልተፈቀደ ምርጫ!" ;;
                OR) echo "Filannoo dogoggora!" ;;
            esac ;;
        # Prompts
        "enter_target_ip")
            case $LANG_CHOICE in
                EN) echo -n "Enter target IP/domain: " ;;
                AM) echo -n "የመርምሪያ አድራሻ/IP ያስገቡ: " ;;
                TI) echo -n "ኣድራሻ ወይ አይፒ ይግቡ: " ;;
                OR) echo -n "IP/domain ka target galchi: " ;;
            esac ;;
        "enter_target_domain")
            case $LANG_CHOICE in
                EN) echo -n "Enter target domain: " ;;
                AM) echo -n "የመርምሪያ ዶሜይን ያስገቡ: " ;;
                TI) echo -n "ዶሜን ይግቡ: " ;;
                OR) echo -n "Domain ka target galchi: " ;;
            esac ;;
        "enter_service")
            case $LANG_CHOICE in
                EN) echo -n "Enter target service (e.g., ssh, ftp): " ;;
                AM) echo -n "የመርምሪያ አገልግሎት ያስገቡ (ssh, ftp ወዘተ): " ;;
                TI) echo -n "ሰርቪስ ይግቡ (ssh, ftp etc.): " ;;
                OR) echo -n "Tajaajila target galchi (e.g., ssh, ftp): " ;;
            esac ;;
        "enter_username")
            case $LANG_CHOICE in
                EN) echo -n "Enter username: " ;;
                AM) echo -n "የተጠቃሚ ስም ያስገቡ: " ;;
                TI) echo -n "ስም ይግቡ: " ;;
                OR) echo -n "Maqaa fayyadamaa galchi: " ;;
            esac ;;
        "enter_wordlist")
            case $LANG_CHOICE in
                EN) echo -n "Enter path to your wordlist: " ;;
                AM) echo -n "የቃላት ዝርዝር መንገድ ያስገቡ: " ;;
                TI) echo -n "Path ta wordlist ይግቡ: " ;;
                OR) echo -n "Daandii wordlist galchi: " ;;
            esac ;;
    esac
}

# -------------------------------
# Install required tools
# -------------------------------
install_tools() {
    msg "installing_tools"
    sudo apt update
    sudo apt install -y nmap wget curl figlet enscript ghostscript hydra seclists
    msg "install_done"

    if [ -f /usr/share/wordlists/rockyou.txt ]; then
        echo "[*] Wordlist ready at /usr/share/wordlists/rockyou.txt"
    elif [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
        sudo gunzip -k /usr/share/wordlists/rockyou.txt.gz
    else
        sudo mkdir -p /usr/share/wordlists/
        sudo wget -O /usr/share/wordlists/rockyou.txt \
            https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
        echo "[*] Wordlist downloaded to /usr/share/wordlists/rockyou.txt"
    fi
}

# -------------------------------
# ASCII Banner
# -------------------------------
ascii_banner() {
    figlet "Pentest Tool"
    echo "-------------------------------------------------------"
    echo "|  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄    | " 
    echo "| ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌   |"
    echo "| ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀    | "
    echo "| ▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌     ▐░▌        | "
    echo "| ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌        | "
    echo "| ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌        | "
    echo "| ▐░▌       ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌     ▐░▌        | "
    echo "| ▐░▌       ▐░▌          ▐░▌▐░▌       ▐░▌     ▐░▌        | "
    echo "| ▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌     ▐░▌        | "
    echo "| ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌     ▐░▌        | "
    echo "|  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀       ▀         | "
    echo "|                 Offensive System Automated Tool       | "
    echo "|                        Automated by Eliab Mesfin V1.0 |  "
    echo "---------------------------------------------------------"
}

# -------------------------------
# Recon Module
# -------------------------------
recon() {
    folder="Recon_$(date '+%Y-%m-%d_%H-%M-%S')"
    mkdir -p "$folder"
    echo "[*] Recon folder created: $folder"

    while true; do
        msg "recon_menu"
        echo "1) Port Scan"
        echo "2) Subdomain Enumeration"
        echo "3) Vulnerability Check"
        echo "4) Back to Main Menu"
        read -p "Choice: " recon_choice

        case $recon_choice in
            1)
                msg "enter_target_ip"
                read target
                nmap -sV $target -oN "$folder/portscan.txt"
                echo "[*] Port scan saved to $folder/portscan.txt"
                ;;
            2)
                msg "enter_target_domain"
                read target
                curl -s https://crt.sh/?q=%25.$target | grep $target > "$folder/subdomains.txt"
                echo "[*] Subdomains saved to $folder/subdomains.txt"
                ;;
            3)
                msg "enter_target_ip"
                read target
                nmap --script vuln $target -oN "$folder/vuln_scan.txt"
                echo "[*] Vulnerability report saved to $folder/vuln_scan.txt"
                ;;
            4) break ;;
            *) msg "invalid" ;;
        esac
    done

    for txtfile in "$folder"/*.txt; do
        pdf_file="${txtfile%.txt}.pdf"
        enscript "$txtfile" -o - | ps2pdf - "$pdf_file"
    done
    echo "[*] PDF reports generated in $folder"
}

# -------------------------------
# Brute Force Module
# -------------------------------
brute_force() {
    msg "enter_service"
    read service
    msg "enter_target_ip"
    read target
    msg "enter_username"
    read user

    while true; do
        msg "bf_menu"
        echo "1) Use my own wordlist"
        echo "2) Use auto wordlist (rockyou.txt)"
        echo "3) Back to Main Menu"
        read -p "Choice: " bf_choice

        case $bf_choice in
            1)
                msg "enter_wordlist"
                read wordlist
                hydra -l $user -P $wordlist $target $service
                ;;
            2)
                if [ -f /usr/share/wordlists/rockyou.txt ]; then
                    wordlist="/usr/share/wordlists/rockyou.txt"
                else
                    wordlist="auto_wordlist.txt"
                    echo -e "123456\npassword\n$target\nadmin\n$user123\nwelcome" > $wordlist
                fi
                hydra -l $user -P $wordlist $target $service
                ;;
            3) break ;;
            *) msg "invalid" ;;
        esac
    done
}

# -------------------------------
# DoS Module (Simulation)
# -------------------------------
dos_attack() {
    msg "dos_menu"
    msg "enter_target_ip"
    read target
    echo "[*] Example command: hping3 -S --flood -V $target"
    echo "!!! Simulation only. Insert real commands if testing in lab."
}

# -------------------------------
# Main Menu
# -------------------------------
main_menu() {
    while true; do
        msg "main_menu"
        echo "1) Reconnaissance"
        echo "2) Brute Force"
        echo "3) DoS Attack"
        echo "4) Exit"
        read -p "Choice: " choice

        case $choice in
            1) recon ;;
            2) brute_force ;;
            3) dos_attack ;;
            4) exit 0 ;;
            *) msg "invalid" ;;
        esac
    done
}

# -------------------------------
# Script Execution
# -------------------------------
select_language
install_tools
ascii_banner
main_menu
