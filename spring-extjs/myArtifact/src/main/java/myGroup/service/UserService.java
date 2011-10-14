package myGroup.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import ch.ralscha.extdirectspring.annotation.ExtDirectMethod;
import ch.ralscha.extdirectspring.annotation.ExtDirectMethodType;

@Named
public class UserService {

	@ExtDirectMethod(ExtDirectMethodType.STORE_READ)
	public List<User> load() {
		List<User> users = new ArrayList<User>();
		users.add(new User("Cassidy", "Vaughn", "Nunc.laoreet@congueturpis.com"));
		users.add(new User("Jayme", "Frost", "egestas.a.dui@nisiaodio.org"));
		users.add(new User("Reece", "Ferrell", "placerat@lacusQuisqueimperdiet.org"));
		users.add(new User("Imelda", "Wong", "mauris.a.nunc@estac.ca"));
		users.add(new User("Carla", "Maynard", "Proin@nonummyultricies.ca"));
		users.add(new User("Whilemina", "Leach", "facilisis@nuncestmollis.org"));
		users.add(new User("Pearl", "Cline", "Sed@Maurisnulla.edu"));
		users.add(new User("Diana", "Clay", "massa.lobortis.ultrices@suscipit.org"));
		users.add(new User("Roanna", "Boyd", "mauris.ut@nonmassa.com"));
		users.add(new User("Carly", "Hester", "vulputate@volutpatornarefacilisis.org"));
		return users;
	}
}
