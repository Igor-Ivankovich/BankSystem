PRICE_CODE = "ZWL|ZMW|ZAR|YER|XXX|XUA|XTS|XSU|XPT|XPF|XPD|XOF|XDR|XCD|XBD|XBC|XBB|XBA|XAU|XAG|XAF|WST|VUV|VND|VES|UZS|UYW|UYU|UYI|USN|USD|UGX|UAH|TZS|TWD|TTD|TRY|TOP|TND|TMT|TJS|THB|SZL|SYP|SVC|STN|SSP|SRD|SOS|SLL|SHP|SGD|SEK|SDG|SCR|SBD|SAR|RWF|RUB|RSD|RON|QAR|PYG|PLN|PKR|PHP|PGK|PEN|PAB|OMR|NZD|NPR|NOK|NIO|NGN|NAD|MZN|MYR|MXV|MXN|MWK|MVR|MUR|MRU|MOP|MNT|MMK|MKD|MGA|MDL|MAD|LYD|LSL|LRD|LKR|LBP|LAK|KZT|KYD|KWD|KRW|KPW|KMF|KHR|KGS|KES|JPY|JOD|JMD|ISK|IRR|IQD|INR|ILS|IDR|HUF|HTG|HRK|HNL|HKD|GYD|GTQ|GNF|GMD|GIP|GHS|GEL|GBP|FKP|FJD|EUR|ETB|ERN|EGP|DZD|DOP|DKK|DJF|CZK|CVE|CUP|CUC|CRC|COU|COP|CNY|CLP|CLF|CHW|CHF|CHE|CDF|CAD|BZD|BYN|BWP|BTN|BSD|BRL|BOV|BOB|BND|BMD|BIF|BHD|BGN|BDT|BBD|BAM|AZN|AWG|AUD|ARS|AOA|ANG|AMD|ALL|AFN|AED"

MESSAGES = {
  :name => "What is your name?",
  :surname => "What is your surname?",
  :patronymic => "What is your patronymic?",
  :tags => "What is your tags?",
  :identification_number => "What is your identification number?",
  :identifier_exists => "such an identifier already exists, try again",
  :current_account_exists => "There is a current account with this price",
  :no_found_identification_number => "No found identification number",
  :currency => "What is your currency?",
  :create_new_account => "you need to create an account",
  :sum => 'sum',
  :help => 'Enter help for using information about functionality.',
  :functional =>       '''
      create_new_user             - Creates a new user.
      create_new_account          - Creates a new account.
      adding_funds                - Replenish the account.
      transfer_funds              - Transfer to another account.
      report_adding_founds        - Report "On the amount of replenishment for a period of time in currency".
      report_transfer_founds      - Report "Average, maximum and minimum amount of transfers by user tags for a period of time".
      report_account_sum          - Report "Sum of all accounts at the current time by currency".
      exit                        - Exiting the application.
      ''',
  :actions => 'What should be done: ',
  :exit => 'Do you really want to exit?',
  :not_enough_funds => "There is no such amount of funds on the sender's account, enter a different number:",
  :no_found_currency => "Currency no found in originator account"

}

TYPE = {
  :text => {
    :type => 'text',
    :message_name => 'What is your Name: ',
    :message_surname => 'What is your Surname: ',
    :message_patronymic => 'What is your Patronymic: '
  },
  :tag => {
    :type => 'tag',
    :message => 'What is your tags(across ;) or leave the field blank: ',
  },
  :number => 'number',
  :sum => {
    :type => 'sum',
    :message => 'How much do you want to transfer'
  },
  :identification_number => {
    :type => 'number',
    :message => 'What is your identification number?',
    :error_message => ' - this identification number already exists, try again'
  },
  :check_account => {
    :type => 'number',
    :message => 'What is your identification number?',
    :error_message => ' - this identification number no found, try again'
  },
  :check_account_originator => {
    :type => 'number',
    :message => 'What is originator identification number?',
    :error_message => ' - this identification number no found, try again'
  },
  :check_account_recipient => {
    :type => 'number',
    :message => 'What is recipient identification number?',
    :error_message => ' - this identification number no found, try again'
  },
  :currency => {
    :type => 'currency',
    :message => 'What is your currency?',
    :error_message => 'There is a current account with this price, need create account:'
  },
  :report_currency => {
    :type => 'report_currency',
    :message => 'Enter currency or leave the field blank:'
  },
  :time => {
    :type => 'time'
  },
  :filter => {
    :type => 'filter',
    :message => 'Enter filter or leave the field blank:'
  },
  :output_format => {
    :type => 'output_format',
    :message => 'Output in file:'
  }
}

SQL_INSERT = {
  :users => "insert into users values ( ?, ?, ?, ?, ? )",
  :account => "insert into account (user_identification_number, currency, sum) values ( ?, ?, 0 )",
  :sum => "update account set sum=(?) where user_identification_number=(?) and currency=(?)",
  :report_sum => "insert into report_adding_found values (?, ?, ?, ?)",
  :report_transfer_sum => "insert into report_transfer_found values (?, ?, ?, ?)"
}



SQL_SELECT = {
  :current_sum => "select sum from account where user_identification_number =(?) and currency=(?)",
  :report_adding_funds => "select ra.currency, ra.time, ra.sum, u.name || ' ' || u.surname || ' '|| u.patronymic As name from users u JOIN report_adding_found ra ON u.identification_number = ra.user_identification_number where u.identification_number = ra.user_identification_number",
  :report_transfer_sum => "select r.currency, r.time, max(r.sum), min(r.sum), avg(r.sum), u.tags from report_transfer_found r JOIN users u on r.user_identification_number = u.identification_number where r.user_identification_number = u.identification_number ",
  :report_acc_sum => "select a.currency, sum(a.sum) ,count(a.currency) as count_acc from account a JOIN users u on a.user_identification_number = u.identification_number where a.user_identification_number = u.identification_number"
}