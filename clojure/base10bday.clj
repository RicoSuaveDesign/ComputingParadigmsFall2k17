(use '[clojure.string :only (join split)])
(use 'clojure.test) 

(require '[clojure.string :as str])


(defn get-year [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 2))))
                        
                        
(deftest get-year-test
  (is (= 2017 (get-year "10/12/2017")))
  (is (= 3100 (get-year "10/31/3100")))
  
  )

(defn get-month [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 0))))
                        
(deftest get-month-test
  (is (= 12 (get-month "12/10/2017")))
  (is (= 4 (get-month "04/30/2017")))
  
  )

(defn get-day [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 1))))
                        
(deftest get-day-test
  (is (= 12 (get-day "10/12/2017")))
  (is (= 31 (get-day "10/31/2017")))
  
  )

(defn evenly-divisible [num divisor]
  (= (mod num divisor) 0))


(deftest even-divisible-test
  (is (= true (evenly-divisible 42 6)))
  (is (= true (evenly-divisible 4000 1000)))
  
  (is (= false (evenly-divisible 13 6)))
  (is (= false (evenly-divisible 1925 23)))
  
  )


(defn leap-year? [year]
  
  
  (let [fourth-year (evenly-divisible year 4)
        century (evenly-divisible year 100)
        fourth-century (evenly-divisible year 400)]
      
      
      (cond
        (or (and fourth-year (not century)) fourth-century) true 
        :else false)))
      
(deftest leap-year-test
    
    (is (= true (leap-year? 2016)))
    (is (= true (leap-year? 2000)))
    (is (= true (leap-year? 2400)))
    
    (is (= false (leap-year? 2017)))
    (is (= false (leap-year? 1900)))
    (is (= false (leap-year? 2014)))
          
          )
      
;; fresh code for this project

(defn new-month? [day month]
  ;(println "new-month")
  (let [month-lengths [31 28 31 30 31 30 31 31 30 31 30 31]]
       
       (cond
         (= (nth month-lengths (- month 1)) day) true ;if the day is the last in the month
         :else false)))
       
(deftest new-month-test
  
  (is (= true (new-month? 30 4)))
  (is (= true (new-month? 31 3)))
  (is (= true (new-month? 28 2)))
  
  (is (= false (new-month? 28 3)))
  (is (= false (new-month? 30 8)))
  
  
  )
        


(defn get-next-date [date]
  (let [month (get-month date)
        day (get-day date)
        year (get-year date)]
      ;(println "pre date fetch")
      
      (cond
        ;check new year
        (and (= month 12) (= day 31)) (join [ "01/01/" (+ year 1)])
        ;check leap day today
        (and (= month 2) (= day 29)) (join [ (+ month 1) "/01/" year ])
        ;check leap day tomorrow
        (and (= month 2) (leap-year? year) (= day 28)) (join [ "02/29/" year])
        ;check if tomorrow is new month
        (new-month? day month) (join [(+ month 1) "/01/" year])
        ;just uptick the day
        :else (join [ month "/" (+ day 1) "/" year]))))
      
(defn fancy-date [date]
  
    (let [month (get-month date)
        day (get-day date)
        year (get-year date)
        month-names ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]]
    
    (join [(nth month-names (- month 1)) " " day ", " year])  
  ))

(deftest fancy-date-test
  (is (= "December 2, 1970" (fancy-date "12/2/1970")))
  (is (= "March 29, 1968" (fancy-date "3/29/1968")))
  
  )

(defn get-dates-long [date]
  (lazy-seq
    (cons (fancy-date date) 
          
           (get-dates-long (get-next-date date)))))
  
      
(defn get-dates [date]
  ;(println "Orig function")
  (lazy-seq
        (cons date 
              
              (get-dates (get-next-date date)))))
            
(deftest get-dates-tests
  (is (= '("01/01/1973" "1/2/1973" "1/3/1973") (take 3 (get-dates "01/01/1973"))))
  (is (= '("01/30/1973" "1/31/1973" "2/01/1973") (take 3 (get-dates "01/30/1973"))))
  (is (not= '("3/1/2017") (nth (get-dates "2/28/2016") 1)))
  
  
  )

(deftest get-long-dates-tests
  (is (= '("February 1, 2017" "February 2, 2017" "February 3, 2017") (take 3(get-dates-long "2/1/2017"))))
    (is (= '("February 28, 2016" "February 29, 2016" "March 1, 2016") (take 3(get-dates-long "2/28/2016"))))
  
  )

;find when nth base 10 birthday is
(defn find-nth-base-10-birthday [birthday n]
  
  ;(print "Your ")
  ;(print n)
  ;(print "th base-10 birthday is on ")
  ;(println (nth (get-dates birthday) (* n 1000)))
  
  (nth (get-dates birthday) (* n 1000))
  )

(deftest base-10-bday-test
  
  ;my birthday
  (is (= "5/7/2018" (find-nth-base-10-birthday "6/11/1996" 8)))
  (is (= "1/31/2021" (find-nth-base-10-birthday "6/11/1996" 9)))
  
  ;tony's birthday
  (is (= "7/6/2016" (find-nth-base-10-birthday "8/11/1994" 8)))
  (is (= "4/2/2019" (find-nth-base-10-birthday "8/11/1994" 9)))
  
  )


(run-tests)

