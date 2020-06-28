package Factory;

import Dao.photographDao;
import DaoRealise.PhotographRealise;

public class photographFactory {
	private static photographFactory photographFactory = null;
	private photographFactory() {
	}
	
	public static photographFactory getPhotographFactory() {
		if(photographFactory == null)
			photographFactory = new photographFactory();
		return photographFactory;
	}
	
	public photographDao getDao() {
		return new PhotographRealise();
	}
}
