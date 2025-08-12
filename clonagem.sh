#!/bin/bash

# Cores
verde="\e[1;32m"
vermelho="\e[1;31m"
azul="\e[1;34m"
branco="\e[1;37m"
amarelo="\e[1;33m"
cinza="\e[0;37m"
reset="\e[0m"

clear
echo -e "${azul}====================================="
echo -e "        SISTEMA DE CLONAGEM DE WHATSAPP"
echo -e "=====================================${reset}"
echo

read -p "Digite o número alvo (DDD + número, ex: 45987512345): " numero

# DDD digitado
ddd_input=${numero:0:2}

# Lista dos DDDs da região para sortear (exemplo Sul do Brasil)
ddds_regionais=(41 42 43 44 45 46 47 48 49)

# Mensagens
mensagens_texto=(
"Oi, tudo bem?" "Chego em 10 minutos" "Não esquece de trazer o documento"
"Pode me ligar?" "Manda a foto agora" "Transferência feita"
"Já saiu do trabalho?" "Compra pão no caminho" "Tá no grupo novo?"
"Preciso falar urgente" "Já chegou em casa?" "Confirma o horário"
"Passa no mercado" "Traz o carregador" "Já tá a caminho?"
"Reunião adiada" "Código de verificação: 493821"
"Me manda o Pix" "Entra no link que te mandei" "Tô esperando"
"Precisa de ajuda?" "Não conta pra ninguém" "Saiu a atualização"
"Pagamento aprovado" "Pedido enviado" "Seu pacote foi entregue"
)

tipos_mensagem=("Texto" "Áudio" "Imagem" "Vídeo")

status_msg=("enviado" "entregue" "lido")

prefixos_fixo=(3 4 7)

nomes=("Maria" "João" "Carlos" "Ana" "Marcos" "Fernanda" "Lucas" "Paula" "Ricardo" "Beatriz" "Rafael" "Sofia")

# Função para gerar número formatado com DDD regional
gerar_numero() {
    local tipo=$(( RANDOM % 2 ))  # 0 fixo, 1 celular
    local ddd_local=${ddds_regionais[$RANDOM % ${#ddds_regionais[@]}]}
    if [[ $tipo -eq 1 ]]; then
        # Celular: começa com 9 + 4 dígitos + 4 dígitos
        parte1=$(( 1000 + RANDOM % 9000 ))
        parte2=$(( 1000 + RANDOM % 9000 ))
        echo "+55 $ddd_local 9${parte1}-${parte2}"
    else
        # Fixo: começa com 3,4 ou 7 + 3 dígitos + 4 dígitos
        prefix=${prefixos_fixo[$RANDOM % ${#prefixos_fixo[@]}]}
        parte1=$(( 100 + RANDOM % 900 ))
        parte2=$(( 1000 + RANDOM % 9000 ))
        echo "+55 $ddd_local ${prefix}${parte1}-${parte2}"
    fi
}

declare -A contatos

criar_contatos() {
    for i in $(seq 1 20); do
        num=$(gerar_numero)
        nome=${nomes[$RANDOM % ${#nomes[@]}]}
        contatos["$num"]="$nome"
    done
}

echo
echo -e "${verde}[+] Conectando ao número ${branco}+55 $ddd_input ${numero:2:4}-${numero:6:4}${reset}"
echo -e "${amarelo}[i] Processando, aguarde 150 segundos...${reset}"
sleep 150

criar_contatos

# Função pra gerar horário (08:00 a 22:59)
gerar_horario() {
    h=$((8 + RANDOM % 15))
    m=$((RANDOM % 60))
    printf "%02d:%02d" $h $m
}

mostrar_mensagem() {
    local num="$1"
    local nome="${contatos[$num]}"
    local hora=$(gerar_horario)
    local tipo_msg=${tipos_mensagem[$RANDOM % ${#tipos_mensagem[@]}]}
    local status=${status_msg[$RANDOM % ${#status_msg[@]}]}
    local texto=""

    case "$tipo_msg" in
        "Texto") texto=${mensagens_texto[$RANDOM % ${#mensagens_texto[@]}]} ;;
        "Áudio") texto="[Mensagem de voz]" ;;
        "Imagem") texto="[Imagem]" ;;
        "Vídeo") texto="[Vídeo]" ;;
    esac

    echo -e "${cinza}[$hora]${reset} ${verde}$nome ${branco}$num${reset}: ${azul}$texto ${amarelo}(${tipo_msg}, ${status})${reset}"
}

# Loop principal
while true; do
    keys=("${!contatos[@]}")
    selecionado=${keys[$RANDOM % ${#keys[@]}]}
    mostrar_mensagem "$selecionado"
    sleep 0.3
done
