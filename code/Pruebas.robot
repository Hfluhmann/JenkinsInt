*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}   http://localhost:3000
${BROWSER}  chrome
${BTN_CREAR}   xpath=//a[contains(text(),"Crear Receta")]
${BTN_VOLVER_LISTA_RECETAS}    xpath=//a[contains(text(),"Volver a Recetas")]
${FIRST_RECIPE}   xpath=//tbody/tr[1]/td[1]/a
${LAST_RECIPE}    xpath=//tbody/tr[last()]/td[1]/a
${BTN_EDIT_FIRST_RECIPE}   xpath=//tbody/tr[1]/td[last()]/a
${BTN_EDIT_LAST_RECIPE}    xpath=//tbody/tr[last()]/td[last()]/a
${TITLE}   xpath=//div/p/strong[contains(text(),"Título")]
${INGREDIENTS}   xpath=//div/p/strong[contains(text(),"Ingredientes")]
${INSTRUCTIONS}   xpath=//div/p/strong[contains(text(),"Instrucciones")]
${TITLE_FORM}    name=recipe[title]
${INGREDIENTS_FORM}    name=recipe[ingredients]
${INSTRUCTIONS_FORM}    name=recipe[instructions]
${URL_FORM}    name=recipe[image]
${BTN_SEND}    name=commit
${CONFIRMATION_MESSAGE_CREATE}   xpath=//p[contains(text(),"Receta creada correctamente")]
${CONFIRMATION_MESSAGE_EDIT}    xpath=//p[contains(text(),"Receta actualizada correctamente")]
${message_ok}   "Test Passed"
${message_error_view}   "Test Failed. couldn't visualize the recipe."
${message_error_create}   "Test Failed. The recipe was not created."
${message_error_edit}   "Test Failed. The recipe was not edited."

*** Test Cases ***
Visualizar receta
    Abrir pagina principal
    Seleccionar primera receta
    Validar informacion receta
    Volver a lista de recetas
Agregar receta
    Seleccionar opcion agregar receta
    Ingresar datos creacion receta
    Validar creacion receta
Editar receta
    Seleccionar editar ultima receta
    Ingresar datos edicion receta
    Validar edicion receta
    Cerrar navegador

*** Keywords ***
Abrir pagina principal
  Open Browser   ${URL}   ${BROWSER}
  Maximize Browser Window
  Sleep  2
Cerrar navegador
  Close Browser
Seleccionar primera receta
  Click Element    ${FIRST_RECIPE}
  Sleep    2
Seleccionar ultima receta
  Click Element    ${LAST_RECIPE}
  Sleep    2
Validar informacion receta
  ${result1}=  Run Keyword And Return Status  Page Should Contain Element  ${TITLE}
  ${result2}=  Run Keyword And Return Status  Page Should Contain Element  ${INGREDIENTS}
  ${result3}=  Run Keyword And Return Status  Page Should Contain Element  ${INSTRUCTIONS}
  Run Keyword And Continue On Failure    Page Should Contain Element  ${TITLE}
  Run Keyword And Continue On Failure    Page Should Contain Element  ${INGREDIENTS}
  Run Keyword And Continue On Failure    Page Should Contain Element  ${INSTRUCTIONS}
  Run Keyword If  ${result1} and ${result2} and ${result3}  Log  ${message_ok}
  ...  ELSE  Log  ${message_error_view}
Volver a lista de recetas
  Click Element    ${BTN_VOLVER_LISTA_RECETAS}
  Sleep  2
Seleccionar opcion agregar receta
  Click Element    ${BTN_CREAR}
  Sleep  2
Ingresar datos creacion receta
  Input Text    ${TITLE_FORM}    Título 1
  Input Text    ${INGREDIENTS_FORM}    Ingredientes
  Input Text    ${INSTRUCTIONS_FORM}    Paso 1
  Click Element    ${BTN_SEND}
  Sleep  2
Validar creacion receta
  ${result}=  Run Keyword And Return Status  Page Should Contain Element  ${CONFIRMATION_MESSAGE_CREATE}
  Run Keyword And Continue On Failure    Page Should Contain Element  ${CONFIRMATION_MESSAGE_CREATE}
  Run Keyword If  ${result}  Log  ${message_ok}
  ...  ELSE  Log  ${message_error_create}
Seleccionar editar ultima receta
  Click Element    ${BTN_EDIT_LAST_RECIPE}
  Sleep  2
Ingresar datos edicion receta
  Input Text    ${TITLE_FORM}    Título 2
  Click Element    ${BTN_SEND}
  Sleep  2
Validar edicion receta
  ${result}=  Run Keyword And Return Status  Page Should Contain Element  ${CONFIRMATION_MESSAGE_EDIT}
  Run Keyword And Continue On Failure    Page Should Contain Element  ${CONFIRMATION_MESSAGE_EDIT}
  Run Keyword If  ${result}  Log  ${message_ok}
  ...  ELSE  Log  ${message_error_edit}