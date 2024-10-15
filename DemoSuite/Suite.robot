*** Settings ***
Suite Setup       Log To Console    START
Suite Teardown    Log To Console    DONE
Library           SeleniumLibrary

*** Variables ***
${URL}            https://www.google.com.tw/
${Browser}        Chrome
@{my_list}        Create List    item1    item2    item3
&{my_dict}        key1=value1

*** Keywords ***
Try    # 函數名稱
    [Arguments]    ${keywords}    @{args}    # 變數
    Run Keyword And Continue On Failure    ${keywords}    @{args}    # 執行步驟

Seach From Google
    [Arguments]    ${search_term}
    Wait Until Element Is Visible    xpath=//textarea[@class='gLFyf']    timeout=5
    Input Text    xpath=//textarea[@class='gLFyf']    ${search_term}
    Wait Until Element Is Visible    xpath=//input[@name='btnK']    timeout=5
    Click Element    xpath=//input[@name='btnK']


*** Test Cases ***
RF_demo
    # 標籤 可根據標籤選擇執行的case
    [Tags]    RF demo    smoke
    # Test Cases前置設置
    [Setup]    Try    Open Browser    ${URL}    ${Browser}
    # Test Cases後置設置 通常用於恢復環境狀態
    [Teardown]    Try    Close Browser
    # 驗證title是否正確
    Try    Title Should Be    Google
    # 使用UserKeyWord進行關鍵字搜尋
    Try    Seach From Google    iphone16
    # 取得搜尋頁面中所有的標題
    Wait Until Element Is Visible    xpath=//h3[@class='LC20lb MBeuO DKV0Md']    timeout=5
    ${getDatas} =    Get WebElements    xpath=//h3[@class='LC20lb MBeuO DKV0Md']
    # 輸出每個標題的文本
    FOR    ${getData}    IN    @{getDatas}
        ${dataText} =    Get Text    ${getData}
        Log To Console    ${dataText}
    END
    Sleep    5


RF_demo1
    [Tags]    RF demo1
    [Setup]    Try    Open Browser    https://tw.yahoo.com/    ${Browser}
    [Teardown]    Try    Close Browser
    Try    Title Should Be    Yahoo奇摩
    Sleep    2


RF_demo2
    [Tags]    RF demo2    smoke
    [Setup]    Try    Open Browser    https://www.baidu.com/    ${Browser}
    [Teardown]    Try    Close Browser
    Try    Title Should Be    百度一下，你就知道
    Sleep    2


