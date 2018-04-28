#!/usr/bin/gawk

BEGIN{
	flag=0;
}


function span(itime,ftime)
{
	split(itime,c,":");
	split(ftime,d,":");
	if(d[1]>=c[1])
	{
		time=(d[1]-c[1])*3600+(d[2]-c[2])*60+(d[3]-c[3]);
	}
	else
	{
		time=24*3600+(d[1]-c[1])*3600+(d[2]-c[2])*60+(d[3]-c[3]);
	}
	return time;
}

function overlap(processed,seq,ind,retrans)
{
	split(seq,x,/,/);
	split(x[1],b,":");
	if(length(processed[ind])==0)
	{
		processed[ind]=(b[1]":"b[2]",")
		return;
	}
	split(processed[ind],rep,/,/);
	for(i in rep)
	{
		if( rep[i] ~ /:/)
		{
		split(rep[i],a,":");
		if(b[1]>=a[2] || b[2]<=a[1])
		{
			continue;
		}
		if(a[1]<=b[1])
		{
			if(a[2]>=b[2])
			{
				retrans[ind]+=b[2]-b[1];
				return;
			}
			else
			{
				retrans[ind]+=a[2]-b[1];
				newip=(a[2]":"b[2]",");
				overlap(processed,newip,ind,retrans)
				return;
			}
		}
		else
		{
			if(b[2]<=a[2])
			{
				retrans[ind]+=b[2]-a[1];
				newip=(b[1]":"a[1]",");
				overlap(processed,newip,ind,retrans);
				return;
			}
			else
			{
				retrans[ind]+=a[2]-a[1];
				newip1=(b[1]":"a[1]",");
				a2=a[2];
				b2=b[2];
				overlap(processed,newip1,ind,retrans);
				newip2=(a2":"b2",");
				overlap(processed,newip2,ind,retrans);
				return;
			}
		}
		}
	}
	
	processed[ind]=(processed[ind]b[1]":"b[2]",");
	return;
}



{
	split($5,nip,":");
	ind=($3"-"nip[1]);
	if(length(packet[ind])==0)
	{
		itime[ind]=$1;
		if($NF==0)
		{
			packet[ind]++;
			datapacket[ind]=0;
			byte[ind]=0;
			retrans[ind]=0;
		}
		else
		{
			packet[ind]++;
			datapacket[ind]++;
			byte[ind]+=$NF;
			retrans[ind]=0;
			processed[ind]=$9;
		}
	}
	else
	{
		ftime[ind]=$1;
		if($NF==0)
		{
			packet[ind]++;
		}
		else
		{
			packet[ind]++;
			datapacket[ind]++;
			byte[ind]+=$NF;
			seq=$9;
			overlap(processed,seq,ind,retrans);
		}
	}
}

END{

	for(u in packet)
	{
		if(u in comp)
		{
			continue;
		}
		split(u,ip,"-");
		time=span(itime[u],ftime[u]);
		transfer=int((byte[u]-retrans[u])/time);
		print "Connection (A="ip[1]" B="ip[2]")"
		print "A-->B #packets="packet[u]", #datapackets="datapacket[u]", #bytes="byte[u]", #retrans="retrans[u]", #xput="transfer" bytes/sec";
		revip=(ip[2]"-"ip[1]);
		if(length(packet[revip])==0)
		{
			print "B-->A #packets=0, #datapackets=0, #bytes=0, #retrans=0, #xput=0"
			continue;
		}
		time2=span(itime[revip],ftime[revip]);
		transfer2=int((byte[revip]-retrans[revip])/time2);
		print "B-->A #packets="packet[revip]", #datapackets="datapacket[revip]", #bytes="byte[revip]", #retrans="retrans[revip]", #xput="transfer2" bytes/sec";
		comp[revip]=0;
		print " ";
	}
}
