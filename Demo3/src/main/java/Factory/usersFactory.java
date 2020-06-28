package Factory;

import Dao.usersDao;
import DaoRealise.UsersRealise;

public class usersFactory {
	private static usersFactory userFactory = null;
	private usersFactory() {
	}
	
	public static usersFactory getUserFactory() {
		if(userFactory == null)
			userFactory = new usersFactory();
		return userFactory;
	}
	
	public usersDao getDao() {
		return new UsersRealise();
	}
}
