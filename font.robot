
*** Settings ***
Resource    font.resource

*** Test Cases ***
Verificar se existem fontes nao permitidas na pagina
    Verificar se existem fontes nao permitidas na pagina    ${BASE_URL}   ${Lista_fontes_proibidas} 

