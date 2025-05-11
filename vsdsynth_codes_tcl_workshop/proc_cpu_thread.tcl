proc set_multi_cpu_usage {args} {
	array set options {-localCpu <num_of_threads> -help ""}
	foreach {switch value} [array get options] {
		puts "Option $switch is $value"
	}
#	puts "llength is [llength $args]"
#return
	while {[llength $args]} {
		puts "llength is [llength $args]"
		puts "lindex 0 of \"$args\" is [lindex $args 0]"
			switch -glob -- [lindex $args 0] {
				-localCpu {
					puts "Old args is \"$args\""
					set args [lassign $args - options(-localCpu)]
					puts "New args is \"$args\""
					puts "set_num_threads $options(-localCpu)"
				}
				-help {
					puts "Old args is \"$args\""
                                        set args [lassign $args - options(-help)]
                                        puts "New args is \"$args\""
                                        puts "Usage: set_multi_cpu_usage -localCpu <num_of_threads>"
				}
			}
		}
}

set_multi_cpu_usage -localCpu 4 -help			
