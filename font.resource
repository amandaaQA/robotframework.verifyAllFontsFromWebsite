*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
library    String
Library    get_all_urls.py
Library    Collections
Library    OperatingSystem


*** Variables ***
${BASE_URL}                  https://www.google.com.br   #insira a url aqui
@{Lista_fontes_proibidas}    FFDinPro    DIN Pro         #insira as fontes não permitidas aqui
${nome_relatorio}            report_verificacao.csv

*** Keywords ***

Verificar se existem fontes nao permitidas na pagina
    [Arguments]    ${URL}    ${Lista_fontes_proibidas}
    
    Criar arquivo de relatorio    ${nome_relatorio}

    @{LIST_URLS}    Obter todas as URLs da pagina   ${URL}
    
    Open Browser    about:blank    chrome
    
    FOR    ${url}    IN    @{LIST_URLS}
        Navegar para pagina    ${url}

        ${fontes_encontradas}    Obter fontes da pagina
        
        ${status}    Run Keyword And Return Status   
        ...    Verificar se página contem fonte proibida    ${fontes_encontradas}    ${Lista_fontes_proibidas}

        Salvar status no arquivo de texto    
        ...    ${nome_relatorio}    ${url}    ${fontes_encontradas}    ${status}
    END

    Close Browser

Obter todas as URLs da pagina
    [Arguments]    ${URL}
    @{LIST}    Get All Urls    ${URL}
    RETURN    @{LIST}

Navegar para pagina
    [Arguments]    ${url}
    Log To Console    ${\n}--- URL: ${url}
    Go To    ${url}

Obter fontes da pagina
    TRY
        ${font_found_on_page}    Execute JavaScript    return window.getComputedStyle(document.body).fontFamily
        Log To Console    \tFonte: ${font_found_on_page}
        RETURN    ${font_found_on_page}
    EXCEPT    AS     ${message}
        Log To Console    Não foi possível obter as fontes da página. Erro: ${message}
    END
    

Verificar se página contem fonte proibida
    [Arguments]    ${fontes_encontradas}    ${fontes_proibidas}
    IF    ${fontes_encontradas} is not ${EMPTY}:
        FOR    ${fonte_proibida}    IN    @{Lista_fontes_proibidas}
            IF   "${fonte_proibida.lower()}" == "${fontes_encontradas.lower()}"
                FAIL    msg=\tA fonte ${fontes_encontradas} não é permitida!
            END
        END
    ELSE
        FAIL    msg=Não foram encontradas fontes na página!
    END
    

Criar arquivo de relatorio
    [Arguments]    ${nome}
    Append To File    ${nome}    URL,Fonte_encontrada,Status

Salvar status no arquivo de texto
    [Arguments]    ${nome_arquivo}    ${url}    ${fonte}    ${status}
    Append To File    ${nome_arquivo}   \n${url},"${fonte}",${status}