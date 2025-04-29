@Service
public class IpValidationService {
    @Value("${ips.permitidas}")
    private List<String> ipsPermitidas;

    public boolean ipAutorizada(String ip) {
        return ipsPermitidas.contains(ip) || ip.equals("127.0.0.1");
    }
}