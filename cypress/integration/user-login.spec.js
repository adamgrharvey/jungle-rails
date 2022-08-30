describe('User signin/registration testing', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it("login using existing details", () => {
    let userDetails = {
      email: 'adam@ha.com',
      password: 'testing'
    }
    cy.get('a:contains("Login")').first().click()
    cy.get('input').should('have.class', 'form-control').first().click().type(userDetails.email)
    cy.get('input[name="session[password]"').click().type(userDetails.password);
    cy.get('a:contains("Login")').should('be.visible');
    cy.get('input').should('have.class', 'form-control').last().click()
    cy.get(`a:contains(${userDetails.email})`).should('be.visible');
  });
  it("create new user, and login using those details", () => {
    let userDetails = {
      first_name: 'adam',
      last_name: 'harvey',
      email: 'adam@harv.com',
      password: 'testing2'
    }
    cy.get('a:contains("Login")').first().click()
    cy.get('a:contains("Register")').click()
    cy.get('input[name="user[first_name]"').click().type(userDetails.first_name);
    cy.get('input[name="user[last_name]"').click().type(userDetails.last_name);
    cy.get('input[name="user[email]"').click().type(userDetails.email);
    cy.get('input[name="user[password]"').click().type(userDetails.password);
    cy.get('input[name="user[password_confirmation]"').click().type(userDetails.password);
    cy.get('input').should('have.class', 'form-control').last().click()
    cy.get('a:contains("Login")').first().click()
    cy.get('input').should('have.class', 'form-control').first().click().type(userDetails.email)
    cy.get('input[name="session[password]"').click().type(userDetails.password);
    cy.get('a:contains("Login")').should('be.visible');
    cy.get('input').should('have.class', 'form-control').last().click()
    cy.get(`a:contains(${userDetails.email})`).should('be.visible');
    //name="user[first_name]"
    // cy.get('input').should('have.class', 'form-control').first().click().type(userDetails.email)
    // cy.get('input[name="session[password]"').click().type(userDetails.password);
    // cy.get('a:contains("Login")').should('be.visible');
    // cy.get('input').should('have.class', 'form-control').last().click()
    // cy.get('a:contains("Login")').should('not.exist');
  });
});