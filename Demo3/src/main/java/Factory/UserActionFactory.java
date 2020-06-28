package Factory;

import Dao.UsersAction;
import DaoRealise.UsersActionRealise;

public class UserActionFactory {
	private static UserActionFactory userActionFactory = null;
	private UserActionFactory() {
	}
	
	public static UserActionFactory getUserActionFactory() {
		if(userActionFactory == null)
			userActionFactory = new UserActionFactory();
		return userActionFactory;
	}
	
	public UsersAction getDao() {
		return  new UsersActionRealise();
	}
}
