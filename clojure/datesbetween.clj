(require '[clojure.string :as str])


(defn get-year [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 2))))

(defn get-month [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 0))))

(defn get-day [date] 
                        
            (let[datesplit (str/split date #"/")]
                           
                          (. Integer parseInt(nth datesplit 1))))


(defn evenly-divisible [num divisor]
  (= (mod num divisor) 0))


(defn leap-year? [year]
  
  
  (let [fourth-year (evenly-divisible year 4)
        century (evenly-divisible year 100)
        fourth-century (evenly-divisible year 400)]
      
      
      (cond
        (or (and fourth-year (not century)) fourth-century) true 
        :else false)))

(defn days-between-years [year1 year2] (
                                    
                                    let[leap-yr (filter leap-year?(range (+ year1 1) year2))
                                       no-leap (* (- (- year2 1) year1) 365)]
                                     (+ no-leap (count leap-yr))
                                    
                                    ))
                                  
(defn days-left-in-year [month] 
                                           
                                          (let [month-lengths [31 28 31 30 31 30 31 31 30 31 30 31]]
                                           
                                           (reduce + (nthnext month-lengths month)) 
                                           
                                                
                                          ))
                                        
(defn days-left-in-month [month day] 
                                          (let [month-lengths [31 28 31 30 31 30 31 31 30 31 30 31]]
                                          
                                          (- (nth month-lengths (- month 1)) day)     
                                       
                                       ))
                                     
(defn days-in-months-passed [month] 
                                      
                                         (let [month-lengths [31 28 31 30 31 30 31 31 30 31 30 31]]
                                              
                                          (reduce + (drop-last (- 13 month) month-lengths))
                                      
                                      ))
                                  

  
  

(defn get-number-of-days-between
  
  ( [date1 date2]
                                                (let[date1year (get-year date1)
                                                date2year (get-year date2)
                                                  date1month (get-month date1)
                                                date2month (get-month date2)
                                                  date1day (get-day date1)
                                                date2day (get-day date2)]
                                                               ;here be the scope we working
                                                               
                                                              ; (println(date1year))
                                                               (print "There are ")
                                                               (print(+ (days-between-years date1year date2year) (days-in-months-passed date2month) (days-left-in-month date1month date1day) (days-left-in-year date1month) date2day)))
                                                             
                                                             (print " days between ")
                                                             (print date1)
                                                             (print " and ")
                                                             (println date2))
                                                             
    ( []
      
      (println "Enter the first date, and then the second date in mm/dd/yyyy format:")
      (let [date1 (read-line)
            date2 (read-line)]
          (get-number-of-days-between date1 date2))))
           
           
                                    
        ;(println "Enter first date? (mm/dd/yyyy)")
        ;(let [date1 (read-line)]
        ;(println "Enter second date?")
        ;(let[date2 (read-line)
        ;(get-number-of-days-between date1 date2)))))
                                                            
                                      
                                      
                                      
                                                               
                                                               ;(println (+ (days-between-years 2010 2018) 1 ))
                                                               
                                  
(get-number-of-days-between "3/19/1973" "11/3/2017")
(get-number-of-days-between "1/1/2000" "11/3/2017")
(get-number-of-days-between "11/2/2017" "11/3/2017")
(get-number-of-days-between)