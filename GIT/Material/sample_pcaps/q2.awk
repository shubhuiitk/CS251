#!/usr/bin/gawk
BEGIN{

}

function transmit(seq,data,input)
{
	#print data	
	if (data ~ /:/)
	{
		split(data,q,/,/)		
		split(q[1],b,/:/)
		
	}
	else
	{
		return;
	}
	#print b[1] "-------" b[2]	
	split(seq[input],c,/,/)	
	#for (i in c)
	#print c[i]	
	for ( i in c)
	{
		if( c[i] ~ /:/)
		{
			split(c[i],d,/:/)
			if (d[1] >=b[2] || d[2]<=b[1])
			{
				continue
			}
			else
			{
				if (d[1]<=b[1])
				{
					if(d[2]>=b[2])
					{
						transmitted[input]= b[2]-b[1]  + transmitted[input]
						return		
					}
					else
					{
						transmitted[input] = d[2]-b[1] + transmitted[input]
						temp = (d[2]":"b[2])
						transmit(seq,temp,input)
						return
					}
				}
				else
				{	
					if(d[2]>=b[2])
					{
						transmitted[input] = b[2]-d[1] + transmitted[input]
						temp = (b[1]":"d[1])
						transmit(seq,temp,input)
						return
					}
					else
					{
						transmitted[input] = d[2]-d[1] + transmitted[input]
						temp = (b[1]":"d[1])
						d2=d[2]						
						b2 = b[2]
						transmit(seq,temp,input)
						temp = (d2":"b2)
						transmit(seq,temp,input)
						return
					}
				}
			}
		}		
		 		
	}
	#print seq[input]
	if ( b[2]!=b[1])
	{
		seq[input] = (seq[input]b[1]":"b[2]",") 
		#print seq[input]
	}		
	return
}



function duration(time1, time2)
{
	split(time1,t1,":")
	split(time2,t2,":")
	
	if(t2[1] >= t1[1])	
	{
		time = t2[1]*3600-t1[1]*3600 + t2[2]*60-t1[2]*60 + t2[3]-t1[3]
	}
	else
	{
		time = t2[1]*3600-t1[1]*3600+24*3600 + t2[2]*60-t1[2]*60 + t2[3] -t1[3]
	}	
	return time

}





{
	
	split($5,sep,":")	
	input= ($3" "sep[1])
	
	if(length(arr[input])==0)
	{
		start[input]=$1
		transmitted[input]=0
		total[input] = $NF		
		if($NF ==0)
		{
			arr[input] =(1" "0" "$NF)
		
		}				
		else
		{
			arr[input] =(1" "1" "$NF)
			seq[input] = $9
		}
	}
	else
	{
		total[input] = total[input] + $NF		
		end[input] = $1		
		split(arr[input],a,/ /)
		a[1]++
		a[3] = a[3] + $NF
		if($NF !=0)
		{
			a[2]++
			value=$9
			
			transmit(seq,value,input)
		}				
		
		arr[input]= (a[1]" "a[2]" "a[3])
	}
	#print transmitted[input]


   	
}

END{

	      
      for (k in arr)
	{
		if(k in brr)
		{			
			continue;
		}		
		split(k,ip," ")
		print "Connection (A= "ip[1]" B="ip[2]")"		
		
		split(arr[k],ans," ")
		span = duration(start[k],end[k])
		unique = int((total[k]-transmitted[k])/span)
		print "A-->B #packets="ans[1]", #datapackets="ans[2]", #bytes="ans[3]", #retrans="transmitted[k]", #xput="unique" bytes/sec" 	
		
		new_ip = (ip[2]" "ip[1])
		if(length(arr[new_ip])==0)
		{
	  		print "B-->A #packets=0, #datapackets=0, #bytes=0, #retrans=0, #xput=0 bytes/sec"
			continue
		}
		split(arr[new_ip],jkl," ")
		span = duration(start[new_ip],end[new_ip])
		unique = int((total[new_ip]-transmitted[new_ip])/span)
	  print "B-->A #packets="jkl[1]", #datapackets="jkl[2]", #bytes="jkl[3]", #retrans="transmitted[new_ip]", #xput="unique" bytes/sec"
				
		result = (ip[2]" "ip[1])
		brr[result]=0		
		print " "
		
		
		
	}
}
