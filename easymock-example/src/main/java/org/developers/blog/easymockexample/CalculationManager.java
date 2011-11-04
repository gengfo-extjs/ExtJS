package  org.developers.blog.easymockexample;



/**
 * Hello world!
 *
 */
public class CalculationManager {

    private IMultiplicationService multiplicatorService;

    public IMultiplicationService getMultiplicatorService() {
        return multiplicatorService;
    }

    public void setMultiplicatorService(IMultiplicationService multiplicatorService) {
        this.multiplicatorService = multiplicatorService;
    }

    public Integer calculatePrice(Integer price, Integer amount, Integer reduction) {
        return multiplicatorService.multiply(price, amount) - reduction;
    }
}
