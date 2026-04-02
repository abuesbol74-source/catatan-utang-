#!/bin/bash

# --- Warna ---
MERAH='\033[1;31m'
NORMAL='\033[0m'
HIJAU='\033[0;32m'
KUNING='\033[1;33m'
CYAN='\033[0;36m'

# --- File Database ---
DATABASE="catatan_hutang_april_2026.txt"

tampilkan_header() {
    clear
    echo -e ""
    echo "██████╗  █████╗ ██╗   ██╗ █████╗ ██████╗     ██╗  ██╗██╗   ██╗████████╗ █████╗ ███╗   ██╗ ██████╗ "
    echo "██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗    ██║  ██║██║   ██║╚══██╔══╝██╔══██╗████╗  ██║██╔════╝ "
    echo "██████╔╝███████║ ╚████╔╝ ███████║██████╔╝    ███████║██║   ██║   ██║   ███████║██╔██╗ ██║██║  ███╗"
    echo "██╔══██╗██╔══██║  ╚██╔╝  ██╔══██║██╔══██╗    ██╔══██║██║   ██║   ██║   ██╔══██║██║╚██╗██║██║   ██║"
    echo "██████╔╝██║  ██║   ██║   ██║  ██║██║  ██║    ██║  ██║╚██████╔╝   ██║   ██║  ██║██║ ╚████║╚██████╔╝"
    echo "╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
    echo -e ""

    TEXT=">>>-{ where anonymous : by LAKSAMANA DZU NUR AIN }-<<<"
    for (( i=0; i<${#TEXT}; i++ )); do echo -ne "${MERAH}${TEXT:$i:1}"; sleep 0.01; done
    echo -e "${NORMAL}\n"
}

start_catat() {
    tampilkan_header
    echo -e "${CYAN}[ INPUT CATATAN HUTANG APRIL 2026 ]${NORMAL}"
    read -p "Masukkan angka tanggal (1-30): " tgl_pilih
    
    # Perbaikan untuk Termux & Kali Linux agar deteksi hari akurat
    HARI_ENG=$(date -d "2026-04-$tgl_pilih" +"%A" 2>/dev/null || date -f - +"%A" <<< "2026-04-$tgl_pilih")
    
    case $HARI_ENG in 
        Monday) HARI="Senin" ;; Tuesday) HARI="Selasa" ;; Wednesday) HARI="Rabu" ;; 
        Thursday) HARI="Kamis" ;; Friday) HARI="Jumat" ;; Saturday) HARI="Sabtu" ;; Sunday) HARI="Minggu" ;; 
        *) HARI="Hari" ;;
    esac

    echo -e "\n------------------------------------"
    echo -e "${MERAH}Hari $HARI tgl $tgl_pilih bulan 4 Tahun 2026${NORMAL}"
    echo -e "------------------------------------"
    read -p "Nama/Keperluan       = " nama
    read -p "Jumlah Hutang        = " jumlah
    read -p "Status (Lunas/Belum) = " status
    read -p "Tambahan             = " tamb

    echo "------------------------------------" >> $DATABASE
    echo "Hari $HARI tgl $tgl_pilih bulan 4 Tahun 2026" >> $DATABASE
    echo "Nama/Keperluan       = $nama" >> $DATABASE
    echo "Jumlah Hutang        = $jumlah" >> $DATABASE
    echo "Status (Lunas/Belum) = $status" >> $DATABASE
    echo "Tambahan             = $tamb" >> $DATABASE
    echo -e "\n${HIJAU}Catatan Hutang disimpan!${NORMAL}"; sleep 2
}

lihat_catatan() {
    tampilkan_header
    if [ -f "$DATABASE" ]; then 
        echo -e "${MERAH}======= DAFTAR CATATAN HUTANG =======${NORMAL}"
        cat "$DATABASE"
        echo -e "${MERAH}=====================================${NORMAL}"
        echo -e "\nTekan Enter untuk kembali ke menu..."
        read
    else 
        echo -e "${MERAH}Kosong.${NORMAL}"; sleep 1; 
    fi
}

while true; do
    tampilkan_header
    echo -e "${MERAH}1.${NORMAL} Start Catat (HUTANG)"
    echo -e "${MERAH}2.${NORMAL} Lihat Catatan"
    echo -e "${MERAH}3.${NORMAL} Exit"
    echo ""
    read -p "Pilih menu : " pilih
    case $pilih in 
        1) start_catat ;; 
        2) lihat_catatan ;; 
        3) echo -e "${HIJAU}Program dihentikan. Keluar...${NORMAL}"; exit ;;
        *) echo -e "${MERAH}Pilihan salah!${NORMAL}"; sleep 1 ;;
    esac
done
