*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
library    String
Library    get_urls.py
Library    Collections
Library    OperatingSystem


*** Variables ***
${GET_URL_AUTOMATICALLY}    ${False}
${BASE_URL}                 https://www.insiraURL.com.br/   #insira a url aqui para obter automaticamente as urls do site através do mapa
@{LISTA_URLS}               https://www.insiraURL.com.br/A     https://www.insiraURL.com.br/B    #Se o site não tiver mapa, então insira as urls que você quer verificar aqui
${COOKIE_NAME}              insira_aqui_o_nome_do_cookie_authenticacao    # Authenticacao
${COOKIE_VALUE}             insira_aqui_o_value_do_cookie_authenticacao   # Authenticacao


@{Lista_fontes_proibidas}   FFDinPro    DIN Pro         #insira as fontes não permitidas aqui
${nome_relatorio}           report_verificacao.csv
${sleep_time}               5s

*** Keywords ***

Verificar se existem fontes nao permitidas na pagina
    
    Criar arquivo de relatorio    ${nome_relatorio}    
    Abrir Navegador
    
    IF   ${GET_URL_AUTOMATICALLY} == ${True}
        @{LISTA_URLS}    Obter todas as URLs da pagina    ${BASE_URL}    
    END
    
    FOR    ${url}    IN    @{LISTA_URLS}
        
        Navegar para pagina    ${url}

        ${fontes_encontradas}    Obter fontes da pagina
        
        Salvar status no arquivo de texto    
        ...    ${nome_relatorio}    ${url}    ${fontes_encontradas}
    END

    Fechar Navegador

Obter todas as URLs da pagina
    [Arguments]    ${URL}
    @{LIST}    Get All Urls    ${URL}
    RETURN    @{LIST}

Navegar para pagina
    [Arguments]    ${url}
    Log To Console    ${\n}--- URL: ${url}
    Go To    ${url}
    SeleniumLibrary.Add Cookie    name=${COOKIE_NAME}  value=${COOKIE_VALUE}
    Sleep    ${sleep_time} 

Obter fontes da pagina
    TRY
        ${font_found_on_page}    Execute JavaScript    return window.getComputedStyle(document.body).fontFamily
        Log To Console    \tFonte: ${font_found_on_page}
        RETURN    ${font_found_on_page}
    EXCEPT    AS     ${message}
        Log To Console    Não foi possível obter as fontes da página. Erro: ${message}
    END

Criar arquivo de relatorio
    [Arguments]    ${nome}
    Create File       ${nome}     content=URL,Fonte_encontrada,Status    

Salvar status no arquivo de texto
    [Arguments]    ${nome_arquivo}    ${url}    ${fonte}
    Append To File    ${nome_arquivo}   \n${url},"${fonte}"

Abrir Navegador
    Open Browser    about:blank    Chrome    executable_path=C:/chromedriver.exe

Fechar Navegador
    Close Browser
